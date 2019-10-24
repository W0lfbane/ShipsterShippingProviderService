'use strict';

const axios = require('axios');

const client = axios.create({
    baseURL: 'http://localhost:3000/api/v1',
    headers: {'Accept': 'application/json'}
});

export default {
    get: (params = {}) => client.get('/shipping_providers', params),
    post: (params = {}) => client.post('/shipping_providers', params),
    put: (params = {}) => client.put(`/shipping_providers/${params.id}`, params),
    delete: (params = {}) => client.delete(`/shipping_providers/${params.id}`, params)
}