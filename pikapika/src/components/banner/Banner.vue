<template>
  <div id="banner" class="banner-box">
    <div class="user-wrap">
      <img :src="avtar" alt @click="handleClick" />
      <div class="button-wrap">
        <el-button v-if="!logged" class="button" type="text" @click="handleClick">登录</el-button>
        <el-button v-if="!logged" class="button" type="text" @click="register">注册</el-button>
        <el-button v-else class="button" type="text" @click="logout">注销</el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Banner",
  data() {
    return {
      avtar: "",
      user: {}
    };
  },
  computed: {
    logged() {
      return JSON.parse(localStorage.getItem("pk_user_logged"));
    }
  },
  created() {
    // console.log("user", this.user);
    this.user = this.logged
      ? JSON.parse(localStorage.getItem("logged_user"))
      : {
          u_avatar: "../../../static/imgs/user/userAvatar.jpg"
        };
    this.avtar = this.user.u_avatar;
  },
  methods: {
    handleClick() {
      console.log("click");
      console.log("this.logged", this.logged);
      if (!this.logged) {
        this.$router.push("/login");
      }
    },

    register(){
      this.$router.push("/register");
    },

    logout() {
      localStorage.removeItem("logged_user");
      localStorage.removeItem("pk_user_logged");
      location.reload(true);
    }
  }
};
</script>

<style lang="less" scoped>
.banner-box {
  margin: 0 auto;
  position: relative;
  z-index: 0;
  min-height: 155px;
  min-width: 999px;
  background-color: #f9f9f9;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-pack: center;
  justify-content: center;
  background-repeat: no-repeat;
  background-position: center 0;
  background-size: cover;
  background-image: url(../../../static/imgs/banner/banner.png);

  .user-wrap {
    // width: 100px;
    padding: 10px;
    height: 40px;
    position: absolute;
    top: 20px;
    right: 10%;
    border-radius: 10px;
    background: rgba(0, 0, 0, 0.2);
    img {
      height: 40px;
      width: 40px;
      border-radius: 50%;
      border: 1px solid rgba(0, 0, 0, 0.1);
    }

    img:hover {
      cursor: pointer;
    }

    .button-wrap {
      position: relative;
      margin-left: 10px;
      top: -13px;
      display: inline-block;
      .button {
        color: white;
        font-size: 18px;
        text-shadow: 0 1px 1px rgba(0, 0, 0, 1);
      }
    }
  }
}
</style>