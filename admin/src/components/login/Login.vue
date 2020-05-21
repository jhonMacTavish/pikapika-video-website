<template>
  <div class="login-box" :style="`background: url(${imgurl})`">
    <div class="click-bgm"  @click="fetch"></div>
    <el-card class="box-card">
      <div slot="header" class="header">
        <span>登录</span>
      </div>
      <el-form
        :model="loginForm"
        :rules="rules"
        ref="loginForm"
        label-position="left"
        label-width="50px"
        class="form"
      >
        <el-form-item label="邮箱" prop="email">
          <el-input type="text" placeholder="邮箱" v-model="loginForm.email"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" placeholder="密码" v-model="loginForm.password"></el-input>
        </el-form-item>
        <div class="button-wrap">
          <el-button type="primary" class="login-button" @click.native="login('loginForm')">登录</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    let validateEmail = (rule, value, callback) => {
      let reg = /\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/;
      if (!value) {
        callback(new Error("请输入邮箱")); // 请输入绑定邮箱
      } else if (!reg.test(value)) {
        callback(new Error("请输入正确的邮箱地址格式")); // 请输入正确的邮箱地址格式
      } else {
        callback();
      }
    };

    let validatePsw = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入密码")); // 请输入密码
      } else {
        callback();
      }
    };
    return {
      imgurl: "",
      loginForm: {
        email: "",
        password: ""
      },
      rules: {
        email: [{ validator: validateEmail, trigger: "blur" }],
        password: [{ validator: validatePsw, trigger: "blur" }]
      }
    };
  },
  computed: {},
  watch: {},
  async created() {
    await this.fetch();
    let res = await this.$http.get('/verifytoken');
    if(res && res.data.status==200){
      this.$router.push("/");
      return
    }
  },
  methods: {
    async fetch() {
      let resI = await this.$http.get("/image");
      this.imgurl = resI.data.imgurl;
    },

    async login() {
      let params = {};
      params.a_email = this.loginForm.email;
      params.a_password = this.loginForm.password;
      let res = await this.$http.post("login", { params });
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        sessionStorage.setItem("adminUser",JSON.stringify(res.data.user));
        localStorage.token = res.data.user.token;
        localStorage.super_admin = res.data.user.super_admin;
        this.$router.push("/");
        return;
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.login-box {
  position: relative;
  height: 100vh;
  width: 100%;
  background-size: cover !important;
  background-position: center !important;
  background-repeat: no-repeat !important;
  .click-bgm{
    position: absolute;
    width: 100%;
    height: 100%;
  }

  .box-card {
    position: absolute;
    width: 400px;
    height: 300px;
    background: rgba(255, 255, 255, 0.8);
    top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);

    .header {
      font-size: 24px;
      font-weight: bold;
      letter-spacing: 10px;
    }

    .form {
      margin: 0 20px;

      .button-wrap {
        position: relative;
        width: 100%;

        .login-button {
          position: absolute;
          width: 80px;
          right: 0;
        }
      }
    }
  }
}
</style>
