<template>
  <div id="app">
    <Nav v-if="visible" />
    <transition name="fade" mode="out-in">
      <router-view :class="visible ? 'container' : ''" />
    </transition>
  </div>
</template>

<script>
import Nav from "./components/Nav";

export default {
  components: {
    Nav
  },
  data: () => {
    return {
      visible: false
    };
  },
  mounted() {
    if (localStorage.token != null) {
      if (window.location.href.contains("/login" || "/register")) {
        this.visible = false;
      } else {
        this.visible = true;
      }
    }
  }
};
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body,
html {
  background: #f1f3f5;
  width: 100vw;
}
#app {
  margin: 0;
  padding: 0;
}

.container {
  padding-top: 100px;
}
</style>
