<template>
  <section>
    <Nav />
    <div class="container">
      <div class="top">
        <h1>Discover the world’s top designers & creatives.</h1>
      </div>
      <ul>
        <li v-for="post in posts" :key="post._id">
          <Card
            v-bind:title="post.title"
            v-bind:likes="post.likes.counter"
            v-bind:image="post.preview"
            v-bind:author="post.author"
          />
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

const API_URL = "http://localhost:5000/api/posts/";

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
    fetch(API_URL, {
      method: "GET"
    })
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          return response.statusText;
        }
      })
      .then(result => {
        this.posts = result;
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