<template>
  <section>
    <Nav />
    <div class="container">
      <div class="top">
        <h1>Discover the world’s top designers & creatives.</h1>
      </div>
      <ul>
        <li v-for="post in posts" :key="post._id">
          <Card v-bind:post="post" />
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

const userToken = localStorage.token;

const POSTS_URL = "https://bucketdesign.herokuapp.com/api/posts/";
const USER_URL = `https://bucketdesign.herokuapp.com/auth/token/${userToken}`;

export default {
  name: "Home",
  components: {
    Nav,
    BottomBar,
    Card
  },
  data: () => {
    return {
      posts: []
    };
  },
  mounted() {
    axios.get(POSTS_URL).then(response => {
      this.posts = response.data;
    });
    axios.get(USER_URL).then(response => {
      axios.get();
    });
  }
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/animations.scss";
@import "../assets/scss/variabless.scss";
@import "../assets/scss/mainLayout.scss";

ul {
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  padding: 10px 20px;
  margin-bottom: 80px;
  list-style: none;
  li {
    margin: 20px 0;
  }
}
</style>