<template>
  <div class="main">
    <h1>{{title}}</h1>
    <Chart v-if="datacollection" :chart-data="datacollection" />
  </div>
</template>

<script>
import Chart from "./Chart";
import Labels from "@/assets/json/ChartLabels.json";

export default {
  components: {
    Chart,
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
</style>