import Vue from 'vue';
import Router from 'vue-router';
import LandingPage from '../App.vue';
import NotFound from '../views/nf.vue';

Vue.use(Router);

const routes = [
    {
        path: '/',
        name: 'Home',
        component: LandingPage,
    },
    {
        path: '*',
        name: 'Not Found',
        component: NotFound,
    },
];

const router = new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
});

export default router;