'use strict';

const axios = require('axios');

const client = axios.create({
    baseURL: 'http://localhost:3000/api/v1',
    headers: {'Accept': 'application/json'}
});

export default {
    get: (params = {}) => client.get('/shipping_rates', params),
    post: (params = {}) => client.post('/shipping_rates', params),
    put: (params = {}) => client.put(`/shipping_rates/${params.id}`, params),
    delete: (params = {}) => client.delete(`/shipping_rates/${params.id}`, params)
}