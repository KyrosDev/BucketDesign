<template>
  <nav>
      <div class="image-container">
          <a href="/">
            <img src="../assets/images/nav_logo.svg" alt="NavBar Logo">
          </a>
      </div>
  </nav>
</template>

<script>
export default {
    name: "NavBar",
    data :() => {
        return {};
    }
}
</script>

<style lang="scss">
@import '@/assets/scss/navbar.scss';
</style>