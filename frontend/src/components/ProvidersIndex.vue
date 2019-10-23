<template>
  <div>
    <h1>Providers List</h1>
    <ul>
      <li class="title">
        <div>Company Name</div>
        <div>Total</div>
      </li>
      <li v-for="p in providers" :key="p.name">
        <div>{{ p.name }}</div>
        <div>{{ p.rate.total }} {{ p.rate.currency }}</div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'ProvidersIndex',
  data () {
    return {
      providers: this.getProviders()
    }
  },
  methods: {
    async getProviders () {
      const providers = await this.$http.ShippingProviderService.get()
      return providers.map(provider => Object.assign({
        name: provider.company,
        rate: {
          total: provider.rate,
          currency: provider.rate_currency
        }
      }));
    }
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
