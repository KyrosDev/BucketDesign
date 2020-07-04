import Vue from 'vue';
import App from './App.vue';
import Title from './mixins/title';
import router from './router';

Vue.config.productionTip = false
Vue.mixin(Title)

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
