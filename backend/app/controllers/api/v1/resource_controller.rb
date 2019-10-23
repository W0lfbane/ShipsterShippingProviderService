class Api::V1::ResourceController < ApplicationController  
    before_action :set_resource, except: [:index, :create]
  
    def index
      set_resource_variable(resource_class.all, "@#{resource_name.pluralize}")
      render json: instance_variable_get("@#{resource_name.pluralize}")
    end
  
    def show
      render json: resource
    end
  
    def create
      set_resource_variable(resource_class.create(resource_params))

      if resource.save
        render json: resource, status: :created, location: url_for([:api, :v1, resource])
      else
        render json: resource.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if resource.update(resource_params)
        render json: resource
      else
        render json: resource.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      resource.destroy
    end
  
    private
      
      def resource_name
        controller_name.singularize
      end
  
      def resource_class
        resource_name.camelize.constantize
      end
  
      def resource_params
        eval("#{resource_name}_params")
      end
      
      def set_resource_variable(value, name = "@#{resource_name}")
        instance_variable_set(name, value) unless instance_variable_defined?(name)
      end
  
      def set_resource
        set_resource_variable(params[:id] ? resource_class.find(params[:id]) : resource_class.new)
      end
      
      def resource
        instance_variable_get("@#{resource_name}")
      end
  
  end