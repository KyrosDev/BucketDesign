<template>
  <div class="container">
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
</template>

<script>
import Card from "@/components/DashboardPreviewCard";
import axios from "axios";

export default {
  components: {
    Card,
  },
  props: {
    cardActionOnClick: Function,
  },
  data() {
    return {
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
  },
  methods: {
    getDesigners() {
      const API_URL = "http://localhost:5000/api/v2/designers";
      axios.get(API_URL).then((response) => {
        this.$data.counters[0].info = response.data.length;
      });
    },
  },
};
</script>

<style>
</style>