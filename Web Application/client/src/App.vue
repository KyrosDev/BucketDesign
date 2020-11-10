<template>
  <div id="app">
    <transition name="fade" mode="out-in">
      <router-view :key="$route.path" />
    </transition>
  </div>
</template>

<script>
export default {};
</script>

<style>
@import "./assets/scss/animations.scss";

.fade-enter-active {
  transition: opacity 0.5s;
}
.fade-leave-active {
  opacity: 0;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}

.unselectable {
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  -webkit-tap-highlight-color: transparent;
  user-select: none;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
body,
html {
  scroll-behavior: smooth;
  background: #f1f3f5;
  width: 100vw;
}

html::-webkit-scrollbar {
  display: none;
}
#app {
  margin: 0;
  padding: 0;
}
</style>
