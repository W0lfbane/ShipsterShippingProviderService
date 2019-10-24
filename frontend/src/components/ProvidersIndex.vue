<template>
  <div>
    <div>
      <h1>Providers List</h1>
      <ul>
        <div v-for="p in providers" :key="p.id">
          <li class="title">
            <div>ID</div>
            <div>Company Name</div>
            <div>Total</div>
            <div>Common Total</div>
          </li>
          <li>
            <div>{{ p.id }}</div>
            <div>{{ p.name }}</div>
            <div>{{ p.rate.total }} {{ p.rate.currency }}</div>
            <div>{{ p.commonRate.total }} {{ p.commonRate.currency }}</div>
          </li>
          <h3>Shipping Rates</h3>
          <li class="title">
            <div>ID</div>
            <div>Destination</div>
            <div>Origin</div>
            <div>Total</div>
            <div>Common Total</div>
          </li>
          <div v-for="s in p.shippingRates" :key="s.id">
            <ul>
              <li>
                <div>{{ s.id }}</div>
                <div>{{ s.origin }}</div>
                <div>{{ s.destination }}</div>
                <div>{{ s.rate.total }} {{ s.rate.currency }}</div>
                <div>{{ s.commonRate.total }} {{ s.commonRate.currency }}</div>
              </li>
            </ul>
          </div>
          <br>
        </div>
      </ul>
    </div>
    <div>
      <h1>Save Provider</h1>
      (adding an ID will update existing row)
      <br>
      {{ saveProviderError }}
      <form @submit.prevent="saveProvider">
        ID: <br>
        <input type="text" v-model="providerId"><br>
        Name: <br>
        <input type="text" v-model="providerName"><br>
        Rate: <br>
        <input type="text" v-model="providerRate"><br>
        Currency: <br>
        <input type="text" v-model="providerCurrency"><br>
        <input type="submit" value="Submit">
      </form>
    </div>
    <div>
      <h1>Save Shipping Rate</h1>
      (adding an ID will update existing row)
      <br>
      {{ saveShippingRateError }}
      <form @submit.prevent="saveShippingRate">
        ID: <br>
        <input type="text" v-model="shippingId"><br>
        Origin: <br>
        <input type="text" v-model="shippingOrigin"><br>
        Destination: <br>
        <input type="text" v-model="shippingDestination"><br>
        CompanyId: <br>
        <input type="text" v-model="shipppingCompanyId"><br>
        Rate: <br>
        <input type="text" v-model="shippingRate"><br>
        Currency: <br>
        <input type="text" v-model="shippingCurrency"><br>
        <input type="submit" value="Submit">
      </form>
    </div>
  </div>
</template>

<script>
import ShippingRateService from '../services/ShippingRateService'
import ShippingProviderService from '../services/ShippingProviderService'

const parseShippingRate = (shipping) => Object.assign({
  id: shipping.id,
  origin: shipping.origin,
  destination: shipping.destination,
  companyId: shipping.shipping_provider_id,
  rate: {
    total: shipping.rate,
    currency: shipping.rate_currency
  },
  commonRate: {
    total: shipping.common_rate,
    currency: shipping.common_rate_currency
  }
});

const parseProvider = (provider) => Object.assign({
  id: provider.id,
  name: provider.company,
  rate: {
    total: provider.rate,
    currency: provider.rate_currency
  },
  commonRate: {
    total: provider.common_rate,
    currency: provider.common_rate_currency
  },
  shippingRates: (provider.shipping_rates || []).map(parseShippingRate)
});

export default {
  name: 'ProvidersIndex',
  data () {
    return {
      saveProviderError: '',
      saveShippingRateError: '',
      editProviderError: '',
      editShippingRateError: '',
      shippingId: '',
      shippingOrigin: '',
      shippingDestination: '',
      shipppingCompanyId: '',
      shippingRate: '',
      shippingCurrency: '',
      providerId: '',
      providerName: '',
      providerRate: '',
      providerCurrency: '',
      providers: []
    }
  },
  methods: {
    saveProvider() {
      ShippingProviderService[(this.providerId ? 'put' : 'post')]({
        id: this.providerId,
        shipping_provider: {
          company: this.providerName,
          rate: parseFloat(this.providerRate),
          rate_currency: this.providerCurrency
        }
      }).then(resp => {
        const savedProvider = parseProvider(resp.data);
        const existingProviderId = this.providers.findIndex(provider => provider.id === savedProvider.id);
        if(existingProviderId >= 0) {
          this.providers[existingProviderId] = savedProvider;
        } else {
          this.providers.shippingRates.push(savedProvider);
        }

        this.providerId = '';
        this.providerName = '';
        this.providerRate = '';
        this.providerCurrency = '';
        this.saveProviderError = '';
      }).catch(err => {
        console.error(err);
        this.saveProviderError = err.response.data;
      });
    },

    saveShippingRate() {
      ShippingRateService[(this.shippingId ? 'put' : 'post')]({
        id: this.shippingId,
        shipping_rate: {
          origin: this.shippingOrigin,
          destination: this.shippingDestination,
          shipping_provider_id: this.shipppingCompanyId,
          rate: parseFloat(this.shippingRate),
          rate_currency: this.shippingCurrency
        }
      }).then(resp => {
        const savedShippingRate = parseShippingRate(resp.data);
        const existingProviderId = this.providers.findIndex(provider => provider.id === savedShippingRate.companyId);
        const existingShippingRateId = this.providers[existingProviderId].shippingRates.findIndex(s => s.id === savedShippingRate.id);
        if(existingShippingRateId >= 0) {
          this.providers[existingProviderId].shippingRates[existingShippingRateId] = savedShippingRate;
        } else {
          this.providers[existingProviderId].shippingRates.push(savedShippingRate);
        }

        this.shippingId = '';
        this.shippingOrigin = '';
        this.shippingDestination = '';
        this.shipppingCompanyId = '';
        this.shippingRate = '';
        this.shippingCurrency = '';
        this.saveShippingRateError = '';
      }).catch(err => {
        console.error(err);
        this.saveShippingRateError = err.response.data;
      });
    }
  },
  created() {
    ShippingProviderService.get()
      .then(resp => this.providers = resp.data.map(parseProvider))
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
