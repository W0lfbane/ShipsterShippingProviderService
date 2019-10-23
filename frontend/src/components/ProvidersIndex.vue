<template>
  <div>
    <div>
      <h1>Providers List</h1>
      <ul>
        <li class="title">
          <div>Company Name</div>
          <div>Total</div>
          <div>Common Total</div>
        </li>
        <div v-for="p in providers" :key="p.id">
          <li>
            <div>{{ p.name }}</div>
            <div>{{ p.rate.total }} {{ p.rate.currency }}</div>
            <div>{{ p.common_rate.total }} {{ p.common_rate.currency }}</div>
          </li>
          <div v-for="s in p.shipping_rates" :key="s.id">
            <ul>
              <li class="title">
                <div>Destination</div>
                <div>Origin</div>
                <div>Total</div>
                <div>Common Total</div>
              </li>
              <li>
                <div>{{ s.origin }}</div>
                <div>{{ s.destination }}</div>
                <div>{{ s.rate.total }} {{ s.rate.currency }}</div>
                <div>{{ s.common_rate.total }} {{ s.common_rate.currency }}</div>
              </li>
            </ul>
          </div>
          <br>
        </div>
      </ul>
    </div>
  </div>
</template>

<script>
import ShippingProviderService from '../services/ShippingProviderService'

export default {
  name: 'ProvidersIndex',
  data () {
    return {
      providers: []
    }
  },
  methods: {},
  created() {
    ShippingProviderService.get()
      .then(resp => {
        this.providers = resp.data.map(provider => Object.assign({
          id: provider.id,
          name: provider.company,
          rate: {
            total: provider.rate,
            currency: provider.rate_currency
          },
          common_rate: {
            total: provider.common_rate,
            currency: provider.common_rate_currency
          },
          shipping_rates: provider.shipping_rates.map(shipping => Object.assign({
            id: shipping.id,
            origin: shipping.origin,
            destination: shipping.destination,
            rate: {
              total: shipping.rate,
              currency: shipping.rate_currency
            },
            common_rate: {
              total: shipping.common_rate,
              currency: shipping.common_rate_currency
            },
          }))
        }))
      })
      .catch(console.error);
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: flex;
  justify-content: space-between;
  margin: 0 10px;
}

.title {
  font-weight: bold;
  border-bottom: 1px solid #c0c0c0;
  margin-bottom: 10px;
  text-transform: uppercase;
}
</style>
