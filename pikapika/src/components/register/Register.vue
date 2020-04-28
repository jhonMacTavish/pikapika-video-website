<template>
  <div>
    <div class="title-line">
      <span class="tit">{{this.success? '注册成功':'注册'}}</span>
    </div>
    <div v-if="!success" class="register-container">
      <div class="register-img-wrap">
        <div class="img-container">
          <div class="img-left"></div>
          <div class="img-right"></div>
        </div>
      </div>
      <div class="form-wrap">
        <el-form
          :model="regisrerForm"
          :rules="rules"
          ref="regisrerForm"
          label-position="left"
          label-width="70px"
          class="form"
        >
          <el-form-item label="账号" prop="account">
            <el-input type="text" placeholder="账号" v-model="regisrerForm.account"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="psw">
            <el-input type="password" placeholder="密码" v-model="regisrerForm.psw"></el-input>
          </el-form-item>
          <el-form-item label="确认密码" prop="confirmPsw">
            <el-input type="password" placeholder="确认密码" v-model="regisrerForm.confirmPsw"></el-input>
          </el-form-item>
          <el-form-item label="验证码" prop="captcha" class="captcha-wrap">
            <el-input
              placeholder="验证码"
              v-model="regisrerForm.captcha"
              maxlength="4"
              class="captcha"
            ></el-input>
            <el-button type="primary" class="captcha-button">获取验证码</el-button>
          </el-form-item>
          <el-button type="primary" class="register-buttom" @click="register">注册</el-button>
          <div class="login-tip">
            <span @click="turnLogin">已有账号,知己登录></span>
          </div>
        </el-form>
      </div>
    </div>
    <div v-else class="success-box">
      <!-- <div class="message">注册成功！</div> -->
      <div class="image"></div>
      <div class="button-wrap">
        <el-button type="primary" class="button" @click="$router.push({name:'login'})">前往登录页</el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    let validateAccount = (rule, value, callback) => {
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
        callback(new Error("请输入密码")); // 请输入新密码
      } else if (value.length < 6 || value.length > 12) {
        callback(new Error("密码为6-16位")); // 密码为6-16位
      } else if (/\s/.test(value)) {
        callback(new Error("不能含有空白符")); // 不能含有空白符
      } else if (!(/[a-zA-Z]/.test(value) && /\d/.test(value))) {
        callback(new Error("必须同时含有数字和字母")); // 必须同时含有数字和字母
      } else {
        callback();
      }
    };

    let confirmPsw = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.regisrerForm.psw) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };

    let captcha = (rule, value, callback) => {
      console.log(Number(value));
      if (value === "") {
        callback(new Error("请输入验证码"));
      } else if (isNaN(Number(value)) || value.length < 4) {
        callback(new Error("请输入4位数值"));
      } else {
        callback();
      }
    };

    return {
      success: false,
      regisrerForm: {
        account: "",
        psw: "",
        confirmPsw: "",
        captcha: ""
      },
      rules: {
        account: [{ validator: validateAccount, trigger: "blur" }],
        psw: [{ validator: validatePsw, trigger: "change" }],
        confirmPsw: [{ validator: confirmPsw, trigger: "blur" }],
        captcha: [{ validator: captcha, trigger: "blur" }]
      }
    };
  },
  mounted() {
    console.log(this.$route);
  },
  computed: {},
  watch: {},
  beforeDestroy() {
    this.success = false;
  },
  methods: {
    turnLogin() {
      this.$router.push({ path: "/login" });
    },

    register() {
      this.success = true;
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.title-line {
  margin: 0 auto;
  margin-top: 30px;
  margin-bottom: 29px;
  width: 980px;
  height: 28px;
  text-align: center;
  border-bottom: 1px solid #dddddd;
  .tit {
    height: 57px;
    line-height: 57px;
    padding: 0 20px;
    font-size: 38px;
    background: white;
  }
}

.success-box {
  width: 100%;
  // height: 20px;
  // background: turquoise;
  // margin-top: ;
  margin-top: 60px;
  .message {
    margin: 0 auto;
    margin-bottom: 20px;
    text-align: center;
    font-size: 32px;
  }

  .image {
    // display: inline-block;
    margin: 0 auto;
    margin-bottom: 20px;
    width: 200px;
    height: 200px;
    background: url(https://s1.hdslb.com/bfs/static/passport/static/img/result-success.5934aaa.png);
    background-repeat: no-repeat;
    background-position: center;
    background-size: contain;
  }

  .button-wrap {
    width: 200px;
    margin: 0 auto;
    margin-bottom: 30px;
    .button {
      width: 100%;
    }
  }
}

.register-container {
  position: relative;
  width: 980px;
  margin: 0 auto;
  padding: 60px 0;
  .form-wrap {
    width: 420px;
    margin: 0 auto;
    // margin-top: 40px;
    // .item-width {
    //   width: 100%;
    // }

    .form {
      position: relative;
      .el-form-item {
        position: relative;
      }

      .captcha-wrap {
        .captcha {
          width: 60%;
        }

        .captcha-button {
          float: right;
          width: 36%;
        }
      }

      .captcha-wrap::after {
        content: "";
        display: block;
        clear: both;
        visibility: hidden;
      }

      .register-buttom {
        width: 100%;
      }

      .login-tip {
        position: relative;
        margin-top: 10px;
        width: 100%;
        span {
          position: absolute;
          right: 0;
          font-size: 13px;
          color: #00a1d6;
          cursor: pointer;
        }
      }
    }
  }

  .register-img-wrap {
    position: absolute;
    width: 100%;
    height: 200px;
    .img-container {
      position: relative;
      div {
        width: 160px;
        height: 260px;
        position: absolute;
        background: url(https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587663294881&di=62ad5010951a728190388c6dcdcf15b2&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farticle%2F4c3cfc538f94d015b72bf57c8f71dca723c4f976.jpg);
        // background-color: bisque;
        background-repeat: no-repeat;
        background-size: cover;
      }

      .img-left {
        left: 0;
        background-position: -46px 0;
      }

      .img-right {
        background-position: -236px 0;
        right: 0;
      }
    }
  }
}

.register-container::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}
</style>
