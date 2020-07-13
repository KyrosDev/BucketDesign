<template>
  <div id="app">
    <transition name="fade" mode="out-in">
      <router-view />
    </transition>
  </div>
</template>

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
</style>
