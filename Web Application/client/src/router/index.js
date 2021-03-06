import Vue from "vue";
import VueRouter from "vue-router";
import Main from "../views/Main.vue";
import App from "../views/App.vue";
import Null from "../App.vue";
import Login from "../views/Login.vue";
import Register from "../views/Register.vue";
import Customize from "../views/Customize.vue";
import Details from "../views/Details.vue";
import Profile from "../views/Profile.vue";
import Logout from "../views/Logout.vue";
import Dashboard from "../views/Dashboard.vue";
import axios from "axios";

Vue.use(VueRouter);

async function loggedInRedirectApp(to, from, next) {
  const cookie = document.cookie.split("=");
  let token = null;
  if (cookie.length > 0) {
    const value = cookie.indexOf("__bucketdesign_access_token") + 1;
    token = cookie[value];
  }
  if (token.length > 0) {
    const API_URL = `http://localhost:5000/api/auth/authenticate/`;
    const result = await axios.get(API_URL, {
      headers: {
        Authorization: token
      }
    });
    if (result.data.status_code == 401) {
      document.cookie = "";
      localStorage.clear();
      next();
    } else {
      next("/app");
    }
  } else {
    next();
  }
}

async function isLoggedIn(to, from, next) {
  const cookie = document.cookie.split("=");
  let token = null;
  if (cookie.length > 0) {
    const value = cookie.indexOf("__bucketdesign_access_token") + 1;
    token = cookie[value];
  }
  if (token.length > 0) {
    const API_URL = `http://localhost:5000/api/auth/authenticate/`;
    const result = await axios.get(API_URL, {
      headers: {
        Authorization: token
      }
    });
    if (result.data.status_code == 401) {
      document.cookie = "";
      localStorage.clear();
      next("/login");
    } else {
      next();
    }
  } else {
    next("/login");
  }
}

const routes = [
  {
    path: "/",
    name: "landing",
    component: null,
    beforeEnter: isLoggedIn,
  },
  {
    path: "/login",
    name: "login",
    component: Login,
    beforeEnter: loggedInRedirectApp,
  },
  {
    path: "/register",
    name: "register",
    component: Register,
    beforeEnter: loggedInRedirectApp,
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
    path: "/p/:shortcode",
    component: Details,
    name: "details",
  },
  {
    path: "/:username",
    component: Profile,
    name: "profile",
  },
  {
    path: "/logout",
    component: Logout,
    name: "logout",
  },
  {
    path: "/admin/dashboard",
    component: Dashboard,
    name: "admin-dashboard",
    query: {
      display: String,
    },
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
