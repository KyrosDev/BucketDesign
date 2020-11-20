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
    const POSTS_URL = `http://localhost:5000/api/posts/getFeed?from=${
      JSON.parse(localStorage.getItem("designer")).username
    }`;
    const result = await axios.get(POSTS_URL);
    this.getPosts();
  },
  methods: {
    async getPosts() {
      const cachedPosts = localStorage.getItem(
        "__bucketdesign_cached_home_posts"
      );
      if (cachedPosts) {
        const { lastUpdate, posts } = JSON.parse(cachedPosts);
        const oldDate = new Date();
        const newDate = new Date();
        oldDate.setTime(lastUpdate);
        const oldMinutes = oldDate.getMinutes();
        const newMinutes = newDate.getMinutes();
        if (oldMinutes + 10 <= newMinutes) {
          localStorage.removeItem("__bucketdesign_cached_home_posts");
          this.getPosts();
        } else {
          this.posts = posts;
        }
      } else {
        const result = await axios.get("http://localhost:5000/api/posts/all", {
          headers: { "X-Admin-Secret": "asdasd" },
        });
        if (!result.data.message) {
          const data = JSON.stringify({
            posts: result.data,
            lastUpdate: Date.now().toString(),
          });
          localStorage.setItem("__bucketdesign_cached_home_posts", data);
          this.posts = result.data;
        }
      }
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

  @media screen and (min-width: $tablet) {
    display: grid;
    grid-template-columns: calc(50% - 20px) calc(50% - 20px);
    grid-template-areas: "right left";
    gap: 20px;
    padding: 0;
    justify-content: start;
    margin: 0 30px;

    @media screen and (min-width: $desktop) {
      gap: 30px;
      grid-template-columns:
        calc(20% - 30px)
        calc(20% - 30px)
        calc(20% - 30px)
        calc(20% - 30px)
        calc(20% - 30px);
    }

    li {
      width: 100%;
    }
    li:nth-child(even) {
      grid-area: "left";
    }

    li:nth-child(odd) {
      grid-area: "right";
    }
  }
}

@media screen and (min-width: $tablet) {
  .top {
    height: 400px;
    .header {
      font-size: 30px;
    }
  }
}
</style>