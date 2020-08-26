<template>
  <div class="default-content">
    <h1>
      Dashboard
      <span>.</span>
    </h1>
    <div class="wrapper">
      <Chart class="chart" :chart-data="datacollection" />
      <div class="cards-wrapper">
        <Card
          v-for="counter in counters"
          :key="counter.icon"
          :title="counter.title"
          :info="counter.info"
          :icon="counter.icon"
          :iconColor="counter.color"
          :callback="() => cardActionOnClick(counter.id)"
        />
      </div>
    </div>
  </div>
</template>

<script>
import Card from "@/components/DashboardPreviewCard";
import Chart from "@/components/Chart";
import axios from "axios";
import Labels from "@/assets/json/ChartLabels.json";

export default {
  components: {
    Card,
    Chart,
  },
  props: {
    cardActionOnClick: Function,
  },
  data() {
    return {
      datacollection: {
        labels: Labels,
        datasets: [
          {
            label: "New Designers",
            fill: false,
            borderColor: "red",
            borderWidth: 2,
            hoverBackgroundColor: "red",
            data: [0, 200, 20, 50, 20, 50, 100, 0, 346, 23, 61, 42, 23],
          },
          {
            label: "New Posts",
            fill: false,
            borderColor: "blue",
            hoverBackgroundColor: "blue",
            borderWidth: 2,
            data: [10, 63, 31, 13, 62, 84, 53, 0, 96, 36, 41, 12, 23],
          },
          {
            label: "New Messages",
            fill: false,
            borderColor: "orange",
            hoverBackgroundColor: "orange",
            borderWidth: 2,
            data: [48, 412, 20, 14, 20, 5, 100, 30, 1462, 4, 61, 531, 2],
          },
        ],
      },
      counters: [
        {
          title: "Total Designers",
          id: "designers",
          query: "designers",
          info: 0,
          color: "red",
          icon: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>user_smile_icon</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M10,20A10,10,0,1,1,20,10,10,10,0,0,1,10,20Zm0-2a8,8,0,1,0-8-8A8,8,0,0,0,10,18ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"/></g></g></svg>`,
        },
        {
          title: "Total Posts",
          id: "posts",
          query: "posts",
          info: 0,
          color: "blue",
          icon: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>image_icon</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M2,8.1l2-2,5.5,5.5L13,8.1l3,3V2H2Zm0,2.83V16H5.1l3-3L4,8.93ZM7.93,16H16V13.93l-3-3ZM1,0H17a1,1,0,0,1,1,1V17a1,1,0,0,1-1,1H1a1,1,0,0,1-1-1V1A1,1,0,0,1,1,0ZM12.5,7A1.5,1.5,0,1,1,14,5.5,1.5,1.5,0,0,1,12.5,7Z"/></g></g></svg>`,
        },
        {
          title: "Total Messages",
          id: "messages",
          info: 0,
          color: "orange",
          query: "messages",
          icon: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>chat_smile_icon</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M5.29,18.82,0,20l1.18-5.29a10,10,0,1,1,4.11,4.11Zm.29-2.11.65.35a8,8,0,1,0-3.29-3.29l.35.65-.66,3ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"/></g></g></svg>`,
        },
      ],
    };
  },
  mounted() {
    this.getDesigners();
    this.getMessages();
  },
  methods: {
    getDesigners() {
      const API_URL = "http://localhost:5000/api/v2/designers";
      axios.get(API_URL).then((response) => {
        this.$data.counters[0].info = response.data.length;
      });
    },
    getMessages() {
      const API_URL = "http://localhost:5000/api/v2/messages";
      axios.get(API_URL).then((response) => {
        this.$data.counters[2].info = response.data.length;
      });
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/utils.scss";

.default-content {
  width: 100%;
  h1 {
    span {
      color: $main;
    }
    margin-bottom: 40px;
    font-size: 3em;
  }

  .wrapper {
    width: 100%;

    .chart {
      margin-bottom: 40px;
      background: white;
      padding: 40px;
      border-radius: 30px;
    }

    .cards-wrapper {
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
    }
  }
}
</style>