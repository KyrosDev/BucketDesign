import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import VueLuxon from "vue-luxon";
import Cookies from "vue-cookies";


Vue.config.productionTip = false;
Vue.use(VueLuxon);
Vue.use(Cookies);

new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");
