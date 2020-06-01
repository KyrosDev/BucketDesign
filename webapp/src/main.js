import Vue from 'vue';
import App from './App.vue';
import Title from './mixins/title';

Vue.config.productionTip = false
Vue.mixin(Title)

new Vue({
  render: h => h(App),
}).$mount('#app')
