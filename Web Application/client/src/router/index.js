import Vue from "vue";
import VueRouter from "vue-router";
import Main from "../views/Main.vue";
import App from "../views/App.vue";
import Login from "../views/Login.vue";
import Register from "../views/Register.vue";
import Customize from "../views/Customize.vue";
import Details from "../views/Details.vue";
import Profile from "../views/Profile.vue";
import Logout from "../views/Logout.vue";
import axios from "axios";

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
    const API_URL = `https://bucketdesign.herokuapp.com/api/designers/token/verify/${localStorage.token}`;
    axios.get(API_URL).then((response) => {
      if (response.data.message == "invalid token") {
        localStorage.clear();
        next("/login");
      }
    });
    next();
  } else {
    next("/login");
  }
}

const routes = [
  {
    path: "/",
    name: "landing",
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
    name: "profileCustomize",
    component: Customize,
    beforeEnter: isLoggedIn,
  },
  {
    path: "/post/:shortcode",
    component: Details,
    name: "details",
  },
  {
    path: "/designer/:username",
    component: Profile,
    name: "profile",
  },
  {
    path: "/logout",
    component: Logout,
    name: "logout",
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
