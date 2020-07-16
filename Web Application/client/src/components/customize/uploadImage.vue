<template>
  <h1 @click="callback">Upload a profile picture.</h1>
</template>

<script>
export default {
  props: {
    callback: Function
  },
  name: "UploadImage"
};
</script>

<style>
</style>