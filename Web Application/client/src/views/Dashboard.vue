<template>
  <div class="wrap">
    <DashboardTopNavbar />
    <div class="container">
      <DashboardLeftNavbar :decrease="setDimension" :callback="setQuery" />
      <div :class="!expanded ? 'wrapper' : 'wrapper extended'">
        <div class="main" v-for="(c, index) in components" :key="index">
          <transition name="fade" mode="in-out">
            <component v-if="c.name === currentIndex" :is="c.component" v-bind="c.props" />
          </transition>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import DesignersTable from "@/components/DesignersTable";
import DashboardLeftNavbar from "@/components/DashboardLeftNavbar";
import DashboardTopNavbar from "@/components/DashboardTopNavbar";
import Table from "@/components/Table.vue";
import Default from "@/components/DefaultDashboard";

export default {
  components: { Default, DashboardLeftNavbar, DashboardTopNavbar },
  data() {
    return {
      components: [
        {
          name: "default",
          component: Default,
          props: {
            cardActionOnClick: this.setQuery,
          },
        },
        {
          name: "designers",
          component: Table,
          props: { title: "Designers" },
        },
        {
          name: "posts",
          component: Table,
          props: { title: "Posts" },
        },
        {
          name: "messages",
          component: Table,
          props: { title: "Messages" },
        },
        {
          name: "emails",
          component: Table,
          props: { title: "Emails" },
        },
        {
          name: "helper",
          component: Table,
          props: { title: "Helper" },
        },
      ],
      currentIndex: "default",
      expanded: true,
    };
  },
  name: "Dashboard",
  updated() {
    this.setView();
  },
  mounted() {
    try {
      const dash = JSON.parse(localStorage.dashboard);
      this.$data.expanded = dash.expanded;
    } catch (e) {}
    this.setView();
  },
  methods: {
    setDimension() {
      this.$data.expanded = !this.$data.expanded;
      localStorage.dashboard = JSON.stringify({
        expanded: this.$data.expanded,
      });
    },
    setQuery(id) {
      if (id) {
        this.$router
          .push({
            name: "admin-dashboard",
            query: { display: id },
          })
          .catch(() => {});
        this.$data.currentIndex = id;
      } else {
        this.$data.currentIndex = "default";
        this.$router.push({ name: "admin-dashboard" }).catch(() => {});
      }
    },
    setView() {
      const display = this.checkQuery();
      const data = this.$data;
      if (display === {}) {
        data.currentIndex = "default";
      }
      const comps = data.components;
      comps.map((comp) => {
        if (comp.name === display) {
          data.currentIndex = comp.name;
        }
      });
    },
    checkQuery() {
      const route = this.$route.query;
      return route.display;
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/utils.scss";

.container {
  display: flex;
  flex-direction: row;
  .wrapper {
    transition: 0.3s;
    padding: 40px;
    margin-top: 80px;
    width: calc(100% - 80px);
    margin-left: 80px;
    display: flex;
    flex-direction: column;
  }
  .wrapper.extended {
    width: calc(100% - 200px);
    margin-left: 200px;
  }
}
</style>