<template>
  <section>
    <div class="top">
      <p>Hi, designer!</p>
      <h1>Welcome back to BucketDesign.</h1>
    </div>
    <form @submit.prevent="login">
      <div class="form-group">
        <label for="email">Email</label>
        <input v-model="user.email" type="email" name="email" id="email" required />
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input v-model="user.password" type="password" name="password" id="password" required />

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
  </section>
</template>

<script>
import axios from "axios";
import Joi from "joi";

const schema = Joi.object().keys({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required(),
});

const LOGIN_URL = "http://localhost:5000/api/designers/signin";

export default {
  data: () => {
    return {
      errorMessage: "",
      user: {
        email: "",
        password: "",
      },
    };
  },
  methods: {
    login() {
      this.errorMessage = "";
      if (this.validUser()) {
        const body = {
          email: this.user.email,
          password: this.user.password,
        };
        fetch(LOGIN_URL, {
          method: "POST",
          body: JSON.stringify(body),
          headers: {
            "content-type": "application/json",
          },
        })
          .then((response) => {
            if (response.ok) {
              return response.json();
            }
            return response.json().then((error) => {
              throw new Error(error.message);
            });
          })
          .then((result) => {
            localStorage.token = result.token;
            localStorage.user = result.email;

            axios
              .get(`http://localhost:5000/api/designers/email/${localStorage.user}`)
              .then((response) => {
                localStorage.designer = JSON.stringify(response.data);
              });
            this.$router.push("/app");
          })
          .catch((error) => {
            this.errorMessage = error.message;
          });
      }
    },
    validUser() {
      const result = Joi.validate(this.user, schema);
      if (result.error === null) {
        return true;
      }
      this.errorMessage = "Email or Password is invalid. 😬";
      return false;
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/variabless.scss";
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
</style>