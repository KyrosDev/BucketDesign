import Vue from 'vue';
import App from './App.vue';
import router from './router';
import VueLuxon from "vue-luxon";

Vue.config.productionTip = false;
Vue.use(VueLuxon);

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
