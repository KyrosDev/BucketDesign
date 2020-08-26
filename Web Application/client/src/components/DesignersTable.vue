<template>
  <div class="data-display">
    <h1>Dash</h1>
    <h3>Total Designers: {{ designers.length }}</h3>
    <table class="users-table">
      <thead>
        <tr>
          <th class="headCheckbox">
            <input type="checkbox" @change="selectAll()" name="selectAll" id="selectAll" />
          </th>
          <th class="headStatus">Status</th>
          <th class="headId">ID</th>
          <th class="headUsername" @click="sortByUsername">
            Username
            <span>
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 18" width="16" height="16">
                <path fill="none" d="M0 0h24v24H0z" />
                <path fill="white" d="M10 18h4v-2h-4v2zM3 6v2h18V6H3zm3 7h12v-2H6v2z" />
              </svg>
            </span>
          </th>
          <th class="headContacts">Contacts</th>
          <th class="headCreatedAt">Created At</th>
          <th class="headActions">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="designer in designers"
          :key="designer._id"
          :class="selected.includes(designer._id) ? 'active' : null"
        >
          <td>
            <input
              :checked="selectedAll"
              @change="selectRow(designer._id)"
              type="checkbox"
              name="select"
              id="select"
            />
          </td>
          <td>
            <p class="status clean">Clean</p>
          </td>
          <td class="id">{{ designer._id }}</td>
          <td class="username" @click="goProfile(designer.username)">{{ designer.username }}</td>
          <td class="contacts">{{ designer.email }}</td>
          <td class="username">{{ designer.createdAt | luxon }}</td>
          <td class="actions">
            Warn -
            <span @click="changeModalState(designer._id)">Delete</span>
          </td>
        </tr>
      </tbody>
    </table>
    <transition name="fade" mode="in-out">
      <Modal
        v-if="modal"
        type="warning"
        title="Delete designer?"
        message="Warning: This cannot be undone!"
        :actions="[{name: 'Cancel, keep Designer', class: 'secondary', callback: secondary}, {name: 'Yes, delete Designer', class: 'primary', callback: primary}]"
      />
    </transition>
  </div>
</template>

<script>
import axios from "axios";
import luxon from "vue-luxon";
import Modal from "@/components/Modal";

export default {
  name: "DesignersTable",
  components: {
    Modal,
  },
  data: () => {
    return {
      designers: null,
      selectedAll: false,
      selected: new Array(),
      isSorted: false,
      old: new Array(),
      modal: false,
      selectedDesigner: null,
    };
  },
  mounted() {
    this.getDesigners();
  },
  methods: {
    changeModalState(id) {
      this.$data.modal = !this.$data.modal;
      this.$data.selectedDesigner = id;
    },
    getDesigners() {
      const API_URL = "http://localhost:5000/api/v2/designers";
      axios
        .get(API_URL)
        .then((response) => (this.$data.designers = response.data));
    },
    selectRow(id) {
      const slctd = this.$data.selected;
      if (slctd.includes(id)) {
        if (slctd.length === 1) {
          slctd.pop();
        }
        const index = slctd.indexOf(id);
        slctd.splice(index, index);
      } else {
        slctd.push(id);
      }
    },
    selectAll() {
      const data = this.$data;
      const slctdAll = data.selectedAll;
      const arr = data.selected;
      if (slctdAll) {
        data.selectedAll = false;
        arr.splice(0, arr.length);
      } else {
        data.selectedAll = true;
        data.designers.map((designer) => {
          data.selected.push(designer._id);
        });
      }
    },
    sortByUsername() {
      if (!this.$data.isSorted) {
        this.$data.isSorted = true;
        const oldOrder = this.$data.designers;
        this.$data.old = oldOrder;
        this.$data.designers.sort((a, b) =>
          a.username.localeCompare(b.username)
        );
      } else {
        this.$data.isSorted = false;
        this.$data.designers = this.$data.old;
      }
    },
    goProfile(username) {
      this.$router.push({ name: "profile", params: { username: username } });
    },
    deleteUser(id) {
      const API_URL = `http://localhost:5000/api/v2/designers/id/${id}`;
      axios.delete(API_URL).then((response) => {
        console.log(response.data);
        this.$data.selectedDesigner = null;
        this.getDesigners();
      });
    },
    primary() {
      this.deleteUser(this.$data.selectedDesigner);
      this.changeModalState(null);
    },
    secondary() {
      this.changeModalState(null);
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/utils.scss";

.data-display {
  padding: 80px;
  width: 100%;
  justify-self: flex-end;
}

.users-table {
  width: 100%;
  text-align: left;
  border-collapse: collapse;
  border-radius: 10px 10px 0 0;
  overflow: hidden;
  box-shadow: 10px 5px 60px rgba($color: #000000, $alpha: 0.015);
  transition: 0.3s;

  thead {
    tr {
      color: $white;
      margin: 0;
      background: $main;
      border-radius: 10px;
      th {
        margin: 0;
        font-weight: 500;
        font-size: 1em;
        cursor: pointer;
      }
    }
  }

  th,
  td {
    padding: 8px 12px;
  }

  tbody {
    tr {
      border-bottom: 1px solid #dddddd;
      background: white;
      font-weight: 400;
      margin: 8px 12px;
      transition: 0.3s;

      .status {
        transition: 0.3s;
        color: $white;
        text-align: center;
        border-radius: 5px;
        font-size: 0.8em;
        padding: 5px 12px;
      }

      .clean {
        background: $green;
      }
      .banned {
        background: $red;
      }

      .username {
        cursor: pointer;
      }
    }

    .actions {
      color: $red;

      span {
        cursor: pointer;
      }
    }

    tr:nth-child(even) {
      background: #f3f3f3;
    }
    tr:last-of-type {
      border-bottom: 2px solid $main;
    }

    tr.active {
      color: $main;
    }
  }
}
</style>