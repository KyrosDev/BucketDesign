<template>
  <div v-if="loading" class="loader">
    <div class="line icon1"></div>
    <div class="line icon2"></div>
  </div>
  <section v-else>
    <div class="wrapper">
      <div class="top">
        <p>Hi, designer!</p>
        <h1>Welcome back to BucketDesign.</h1>
      </div>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="email">Email</label>
          <input
            v-model="user.email"
            type="email"
            name="email"
            id="email"
            required
          />
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input
            v-model="user.password"
            type="password"
            name="password"
            id="password"
            required
          />

          <transition name="slide-fade">
            <p v-if="errorMessage" class="error">{{ errorMessage }}</p>
          </transition>
          <a class="flat-button">Forgot Password?</a>
        </div>
        <button type="submit" class="button-primary">Sign in</button>
        <div class="register">
          <p>Haven't got an account?</p>
          <router-link to="register">Register now</router-link>
        </div>
      </form>
    </div>
  </section>
</template>

<script>
import axios from "axios";
import Joi from "joi";

const schema = Joi.object().keys({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required(),
});

const LOGIN_URL = "http://localhost:5000/api/auth/login";

export default {
  data: () => {
    return {
      errorMessage: "",
      user: {
        email: "",
        password: "",
      },
      loading: false,
    };
  },
  methods: {
    login() {
      this.$data.loading = true;
      this.errorMessage = "";
      if (this.validUser()) {
        axios
          .post(LOGIN_URL, this.$data.user)
          .then((res) => {
            this.$cookies.set("__bucketdesign_access_token", res.data.token, {
              expires: "1d",
            });
            delete res.data.token;
            delete res.data.password;
            delete res.data.__v;
            delete res.data._id;
            localStorage.designer = JSON.stringify(res.data);
            this.$router.push({ path: "/app" }).catch();
          })
          .catch((error) => {
            this.errorMessage = error.message.message;
          });
      }
    },
    validUser() {
      const result = Joi.validate(this.user, schema);
      if (result.error === null) {
        return true;
      }
      this.errorMessage = "Email or Password is invalid. 😬";
      this.$data.loading = false;
      return false;
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/variables.scss";
@import "../assets/scss/animations.scss";

.top {
  background: $main;
  color: $white;
  height: 40vh;
  padding: 60px 30px;
  border-radius: 0 0 40px 40px;
  @include shadow();
  position: relative;
  p {
    font-weight: 300;
    margin-bottom: 10px;
  }
  h1 {
    font-weight: 500;
  }
}

form {
  margin-top: -60px;
  display: flex;
  flex-direction: column;
  width: 100%;
  padding: 0 30px;

  .form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 30px;
    position: relative;
    input {
      width: 100%;
      border: none;
      outline: none;
      height: 40px;
      border-radius: 10px;
      padding: 5px 10px;
      color: $main;
      font-size: 1.1em;
    }
    label {
      color: $white;
      font-size: 1.4em;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .flat-button {
      margin-left: auto;
      padding: 10px;
      color: $main;
    }
  }

  .form-group:nth-child(2) {
    label {
      color: $main;
    }
  }

  .button-primary {
    color: $white;
    background: $main;
    border: none;
    outline: none;
    padding: 10px 0;
    font-size: 1.2em;
    border-radius: 15px;
    text-transform: uppercase;
    @include shadow();
  }
}

.register {
  margin-top: 30px;
  color: $gray;
  text-align: center;
  font-size: 0.9em;
  a {
    color: $main;
    text-decoration: none;
  }
}

.error {
  background: $red;
  color: $white;
  font-weight: 300;
  padding: 10px 20px;
  border-radius: 6px;
  margin: 10px 0 0 0;
}

@media screen and (min-width: $tablet) {
  section {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    .wrapper {
      width: 100%;
      height: 60%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;

      @media screen and (min-width: $desktop) {
        height: 60%;
      }
    }
    .top {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      width: 70%;
      height: 50%;
      border-radius: 40px;
      padding-bottom: -60px;

      @media screen and (min-width: $desktop) {
        width: 600px;
      }
    }
    form {
      width: 60%;

      @media screen and (min-width: $desktop) {
        width: 550px;
      }
    }
  }
}
</style>