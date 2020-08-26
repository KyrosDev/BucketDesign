<template>
  <nav>
    <div class="main">
      <h1>
        <span>Bucket</span> Design
      </h1>
      <div class="image-container"></div>
    </div>
  </nav>
</template>

<script>
export default {
  name: "TopNavbar",
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/utils.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/mainLayout.scss";

nav {
  width: 100vw;
  height: 80px;
  position: fixed;
  top: 0;
  z-index: 11;
  background: white;
  padding: 20px;
  box-shadow: 0 10px 30px rgba($color: #000000, $alpha: 0.05);
  border-radius: 0 0 30px 0;

  .main {
    position: relative;

    h1 {
      span {
        color: $main;
      }
      position: absolute;
    }

    .image-container {
      position: absolute;
      right: 0;
      width: 35px;
      height: 35px;
      background-color: $main;
      border-radius: 50px;
    }
  }
}
</style>