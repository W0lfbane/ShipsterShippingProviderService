import Vue from 'vue'
import VueAxios from 'vue-axios'

import App from './App.vue'
import ShippingProviderService from './services/ShippingProviderService'

Vue.use(VueAxios, { ShippingProviderService })

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')
