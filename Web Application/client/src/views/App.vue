<template>
  <section>
    <Nav />
    <div class="container">
      <div class="top">
        <h1>Discover the world’s top designers & creatives.</h1>
      </div>
      <ul>
        <li v-for="item in 10" :key="item">
          <Card v-bind:title="'item' + item"  v-bind:likes="item"  v-bind:image="'item'" author="KyrosDesign"/>
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

export default {
  name: "Home",
  components: {
    Nav,
    BottomBar,
    Card
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