<template></template>

<script>
export default {
  mounted() {
    localStorage.clear();
    this.$router.push({ name: "login" });
  },
};
</script>

<style>
</style>