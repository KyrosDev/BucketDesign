<template>
  <div class="container">
    <DashboardNavbar :callback="setQuery" />
    <div class="content">
      <div class="main" v-for="(c, index) in components" :key="index">
        <transition name="fade" mode="in-out">
          <component v-if="c.name === currentIndex" :is="c.component" v-bind="c.props" />
        </transition>
      </div>
    </div>
  </div>
</template>

<script>
import DesignersTable from "@/components/DesignersTable";
import DashboardNavbar from "@/components/DashboardNavbar";
import Table from "@/components/Table.vue";
import Default from "@/components/DefaultDashboard";

export default {
  components: { Default, DashboardNavbar },
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
    };
  },
  name: "Dashboard",
  updated() {
    this.setView();
  },
  mounted() {
    this.setView();
  },
  methods: {
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
  .content {
    padding: 40px;
    display: flex;
    flex-direction: column;
  }
}
</style>