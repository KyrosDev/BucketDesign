<template>
  <div class="main">
    <h1>{{title}}<span>.</span></h1>
    <Chart v-if="datacollection" :chart-data="datacollection" />
    <DesignersTable />
  </div>
</template>

<script>
import Chart from "./Chart";
import Labels from "@/assets/json/ChartLabels.json";
import DesignersTable from "@/components/DesignersTable.vue";

export default {
  components: {
    Chart,
    DesignersTable,
  },
  props: {
    title: String,
  },
  data() {
    return {
      datacollection: null,
    };
  },
  mounted() {
    this.fillData();
  },
  methods: {
    fillData() {
      this.datacollection = {
        labels: Labels,
        datasets: [
          {
            label: "New Designers",
            fill: false,
            borderColor: "red",
            borderWidth: 2,
            data: [0, 200, 20, 50, 20, 50, 100],
          },
        ],
      };
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/utils.scss";

h1 {
  span {
    color: $main;
  }
  margin-bottom: 40px;
  font-size: 3em;
}
</style>