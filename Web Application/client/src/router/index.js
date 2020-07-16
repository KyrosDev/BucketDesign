import Vue from "vue";
import VueRouter from "vue-router";
import Main from "../views/Main.vue";
import App from "../views/App.vue";
import Login from "../views/Login.vue";
import Register from "../views/Register.vue";
import Customize from "../views/Customize.vue";
import Details from "../views/Details.vue";

Vue.use(VueRouter);

function loggedInRedirectDashboard(to, from, next) {
  if (localStorage.token) {
    next("/app");
  } else {
    next();
  }
}

function isLoggedIn(to, from, next) {
  if (localStorage.token) {
    next();
  } else {
    next("/login");
  }
}

const routes = [
  {
    path: "/",
    name: "home",
    component: Main,
  },
  {
    path: "/login",
    name: "login",
    component: Login,
    beforeEnter: loggedInRedirectDashboard,
  },
  {
    path: "/register",
    name: "register",
    component: Register,
    beforeEnter: loggedInRedirectDashboard,
  },
  {
    path: "/app",
    name: "app",
    component: App,
    beforeEnter: isLoggedIn,
  },
  {
    path: "/profile/customize",
    name: "editProfile",
    component: Customize,
    beforeEnter: isLoggedIn,
  },
  {
    path: "/post/:shortcode",
    component: Details,
    name: "details",
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
