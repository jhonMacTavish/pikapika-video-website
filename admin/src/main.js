// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Vuex from 'vuex'
import store from './store/index'

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

import Video from 'video.js'
import 'video.js/dist/video-js.css'
Vue.prototype.$video = Video

Vue.use(ElementUI);
Vue.use(Vuex);

Vue.config.productionTip = true;
import http from './util/http';
Vue.prototype.$http=http;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
