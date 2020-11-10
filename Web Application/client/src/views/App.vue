<template>
  <section>
    <Nav />
    <div class="container">
      <div class="top">
        <h1 class="header">
          Discover the world’s <br />
          top designers & creatives.
        </h1>
      </div>
      <ul>
        <li v-for="post in posts" :key="post._id">
          <Card :post="post" />
        </li>
      </ul>
    </div>
    <BottomBar />
  </section>
</template>

<script>
import Nav from "../components/Nav";
import BottomBar from "../components/bottomBar";
import Card from "../components/cardPreview";
import axios from "axios";

const POSTS_URL = "http://localhost:5000/api/posts/getFeed?from=";

export default {
  name: "Home",
  components: {
    Nav,
    BottomBar,
    Card,
  },
  data: () => {
    return {
      posts: [],
    };
  },
  async mounted() {
    const result = await axios.get(
      POSTS_URL + JSON.parse(localStorage.getItem("designer")).username
    );
    this.getPosts();
  },
  methods: {
    async getPosts() {
      const result = await axios.get("http://localhost:5000/api/posts/all", {
        headers: { "X-Admin-Secret": "asdasd" },
      });
      if (!result.data.status) this.posts = result.data;
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/animations.scss";
@import "../assets/scss/variables.scss";
@import "../assets/scss/mainLayout.scss";

ul {
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column-reverse;
  padding: 10px 20px;
  margin-bottom: 80px;
  list-style: none;
  li {
    margin: 20px 0;
  }
}
</style>