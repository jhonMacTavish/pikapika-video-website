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
          <el-form-item label="用户名" prop="username">
            <el-input type="text" placeholder="用户名" v-model="regisrerForm.username"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input type="text" placeholder="邮箱" v-model="regisrerForm.email"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input type="password" placeholder="密码" v-model="regisrerForm.password"></el-input>
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
            <el-button
              type="primary"
              class="captcha-button"
              @click="getCaptcha"
              :disabled="sendedCaptcha"
            >{{sendedCaptcha?"已发送 "+intervals:"获取验证码"}}</el-button>
          </el-form-item>
          <el-button type="primary" class="register-buttom" @click="register('regisrerForm')">注册</el-button>
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
      <div class="second">{{this.second}}秒后 跳转到登录页面</div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    let validateUsername = (rule, value, callback) => {
      let reg = /^[A-Za-z0-9_]{6,16}$/;
      if (!value) {
        callback(new Error("用户名")); // 请输入用户名
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("用户名由6-16位字母、数字、下划线组成"));
      }
    };

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
      } else if (value !== this.regisrerForm.password) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };

    let captcha = (rule, value, callback) => {
      // //console.log(Number(value));
      if (value === "") {
        callback(new Error("请输入验证码"));
      } else if (isNaN(Number(value)) || value.length < 4) {
        callback(new Error("请输入4位数值"));
      } else {
        callback();
      }
    };

    return {
      IntervalID: 0,
      success: false,
      sendedCaptcha: false,
      intervals: 60,
      second: 3,

      regisrerForm: {
        username: "",
        email: "",
        password: "",
        confirmPsw: "",
        captcha: ""
      },
      rules: {
        username: [{ validator: validateUsername, trigger: "blur" }],
        email: [{ validator: validateEmail, trigger: "blur" }],
        password: [{ validator: validatePsw, trigger: "change" }],
        confirmPsw: [{ validator: confirmPsw, trigger: "blur" }],
        captcha: [{ validator: captcha, trigger: "blur" }]
      }
    };
  },
  mounted() {},
  computed: {},
  watch: {},
  beforeDestroy() {
    this.success = false;
    clearInterval(this.IntervalID);
  },
  methods: {
    turnLogin() {
      this.$router.push({ path: "/login" });
    },

    async register(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          let username = this.regisrerForm.username;
          let email = this.regisrerForm.email;
          let password = this.regisrerForm.password;
          let captcha = this.regisrerForm.captcha;

          let res = await this.$http.post("/register", {
            username,
            email,
            password,
            captcha
          });
          if (res.data.status == 200) {
            //console.log("res", res);
            this.$message({
              type: "success",
              message: res.data.msg
            });
            let IntervalID = setInterval(() => {
              this.second--;
              //console.log(this.second);
              if (this.second <= 0) {
                this.second = 3;
                this.$router.push("/login");
                clearInterval(IntervalID);
              }
            }, 1000);
            this.success = true;
            clearInterval(this.IntervalID);
          } else {
            this.$message({
              type: "error",
              message: res.data.msg
            });
            return false;
          }
        } else {
          // this.$message({
          //   type: "error",
          //   message: "请将表格填写完整"
          // });
          // return false;
        }
      });
    },

    async getCaptcha() {
      let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
      let email = this.regisrerForm.email;
      if (!email || !reg.test(email)) {
        this.$message.error("请输入正确的邮箱地址");
        return;
      } else {
        let res = await this.$http.post("/getCaptcha", { email });
        //console.log("res", res);
        if (res.data.status == 200) {
          this.sendedCaptcha = true;
          sessionStorage.setItem("sendedCaptcha", this.sendedCaptcha);
          this.IntervalID = setInterval(() => {
            this.intervals--;
            //console.log(this.intervals);
            // sessionStorage.setItem("intervals", this.intervals);
            // //console.log("this.intervals", this.intervals);
            if (this.intervals <= 0) {
              this.intervals = 60;
              this.sendedCaptcha = false;
              // sessionStorage.setItem("sendedCaptcha", this.sendedCaptcha);
              clearInterval(this.IntervalID);
            }
          }, 1000);
          // //console.log(, )
        } else {
          this.$message.error(res.data.msg);
        }
      }
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

  .second {
    width: 170px;
    margin: 0 auto;
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
