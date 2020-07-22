<template>
  <div class="container">
    <form @submit.prevent method="post" enctype="multipart/form-data">
      <label for="file">
        <svg v-if="file === ''" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 22 19">
          <title>upload_icon</title>
          <g id="Layer_2" data-name="Layer 2">
            <g id="Layer_1-2" data-name="Layer 1">
              <path
                d="M0,12.5A6.52,6.52,0,0,1,3.06,7,8,8,0,0,1,18.94,7,6.5,6.5,0,0,1,16,19L6,19A6.52,6.52,0,0,1,0,12.5ZM15.85,17a4.5,4.5,0,0,0,2-8.31l-.81-.5L17,7.24a6,6,0,0,0-11.9,0l-.12.94-.81.5a4.5,4.5,0,0,0,2,8.31h9.7ZM12,11v4H10V11H7l4-5,4,5Z"
              />
            </g>
          </g>
        </svg>
        <svg v-else xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
          <path fill="none" d="M0 0h24v24H0z" />
          <path d="M10 15.172l9.192-9.193 1.415 1.414L10 18l-6.364-6.364 1.414-1.414z" />
        </svg>
      </label>
      <input type="file" ref="file" name="file" id="file" accept="image/*" @change="onChange" />
    </form>
    <h1 @click="callback">
      Upload a profile
      <br />picture.
    </h1>
  </div>
</template>

<script>
import axios from "axios";

const API_URL = `http://localhost:5000/api/designers/${localStorage.user}/setup/profile/picture`;
export default {
  props: {
    callback: Function
  },
  data() {
    return {
      file: ""
    };
  },
  name: "UploadImage",
  methods: {
    onChange() {
      const file = this.$refs.file.files[0];
      this.file = file;
      const formData = new FormData();
      formData.append("file", this.file);
      axios
        .post(API_URL, formData)
        .then(response => {
          console.log(response.data);
          if (response.data === "success") {
            this.$props.callback();
          }
        })
        .catch(e => {
          console.log(e);
        });
    }
  }
};
</script>

<style lang="scss" scoped>
@import "../../assets/scss/animations.scss";
@import "../../assets/scss/variabless.scss";
@import "../../assets/scss/mainLayout.scss";
@import "../../assets/scss/utils.scss";

.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  input[type="file"] {
    display: none;
  }

  h1 {
    color: $main;
    font-weight: bold;
    text-align: center;
  }

  label {
    margin-bottom: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 150px;
    width: 150px;
    background: $white;
    border-radius: 20px;

    svg {
      fill: $main;
      width: 70px;
    }
  }
}
</style>