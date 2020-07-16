<template>
  <div class="container">
    <Nav />
    <div class="content">
      <h1 class="title">{{ post.title }}</h1>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Nav from "../components/PostNav";

export default {
  data: () => {
    return {
      post: null
    };
  },
  components: {
    Nav
  },
  mounted() {
    const POST_URL = `https://bucketdesign.herokuapp.com/api/posts/${this.$route.params.shortcode}`;
    axios.get(POST_URL).then(response => {
      if (response.status == 200) {
        this.post = response.data;
      }
    });
  }
};
</script>

<style lang="scss" scoped>
@import '../assets/scss/variabless.scss';
@import '../assets/scss/utils.scss';
@import '../assets/scss/animations.scss';
@import '../assets/scss/mainLayout.scss';

.content {
  padding-top: 100px;
}
</style>