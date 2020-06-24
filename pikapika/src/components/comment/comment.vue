<template>
  <div id="comment" class="comment-box">
    <div class="tip">评论</div>
    <div class="add-comment-wrap">
      <div class="avatar">
        <img :src="user.avatar?user.avatar:avatar" alt />
      </div>
      <div v-if="logged" class="text-area">
        <el-input
          :disabled="!logged"
          type="textarea"
          v-model="textarea"
          :rows="3"
          :cols="128"
          :maxlength="500"
          show-word-limit
          size="medium"
          :placeholder="logged?'请自觉遵守物联网相关的政策法规，严禁发布色情、暴力、反动的言论':'请先登录'"
        ></el-input>
      </div>
      <div v-else class="text-mask">
        <span>
          请先
          <el-button type="primary" size="mini" @click="dialogVisible = true">登录</el-button>后发表评论(*╹▽╹*)
        </span>
      </div>
      <div class="publish-button">
        <!-- <el-button type="primary" class="button-style" :disabled="true">主要按钮</el-button> -->
        <button class="button-style" :disabled="!logged" @click="post">发表评论</button>
      </div>
    </div>
    <div>
      <CommentItem
        v-for="(item,index) in pageList"
        @refreshList="handleCurrentChange"
        :key="index"
        :listItem="item"
        :showReview="showReview"
      />
      <div v-if="!totalItems">
        <!-- <div v-if="showReview" class="space">暂未有点评</div>
        <div v-else class="space">暂未有评论</div>-->
        <div class="space">暂未有评论</div>
      </div>
    </div>
    <div class="window-pagination">
      <el-pagination
        @current-change="handleCurrentChange"
        :current-page.sync="currentPage"
        :page-size="5"
        layout="total, prev, pager, next"
        :total="totalItems"
        background
      ></el-pagination>
    </div>
    <el-dialog title="登 录" :visible.sync="dialogVisible" width="460px" class="loginDialog">
      <el-form
        :model="loginForm"
        :rules="rules"
        ref="loginForm"
        label-position="right"
        label-width="70px"
        class="form"
      >
        <el-form-item label="邮箱" prop="email">
          <el-input type="text" placeholder="邮箱" v-model="loginForm.email"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" placeholder="密码" v-model="loginForm.password"></el-input>
        </el-form-item>

        <el-form-item label="验证码" prop="captcha" class="captcha-wrap">
          <el-input placeholder="验证码" v-model="loginForm.captcha" maxlength="4" class="captcha"></el-input>
          <el-button
            type="primary"
            class="captcha-button"
            :disabled="sendedCaptcha"
            @click="getCaptcha"
          >{{sendedCaptcha?"已发送 "+intervals:"获取验证码"}}</el-button>
        </el-form-item>
        <div class="item-wrap">
          <el-checkbox v-model="checked" class="remember">
            <span>记住我</span>
            <span>不是自己的电脑上不要勾选此项</span>
          </el-checkbox>
          <router-link to="register/findpassword" class="forget-password">忘记密码</router-link>
        </div>
        <div class="button-wrap">
          <el-button type="primary" class="login-button" @click.native="login('loginForm')">登录</el-button>
          <el-button type="primary" class="register-button" @click="$router.push('/register')">注册</el-button>
        </div>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import CommentItem from "../common/commentItem/CommentItem";

export default {
  name: "Comment",
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

    let captcha = (rule, value, callback) => {
      //console.log(Number(value));
      if (value === "") {
        callback(new Error("请输入验证码"));
      } else if (isNaN(Number(value)) || value.length < 4) {
        callback(new Error("请输入4位数值"));
      } else {
        callback();
      }
    };
    return {
      textarea: "",
      currentPage: 1,
      pageList: [],
      user: {
        username: "",
        avatar: "../../../static/imgs/user/userAvatar.jpg"
      },
      avatar: "../../../static/imgs/user/userAvatar.jpg",

      dialogVisible: false,
      checked: false,
      sendedCaptcha: false,
      intervals: 60,
      intervalID: 0,
      loginForm: {
        email: "",
        password: "",
        captcha: ""
      },
      rules: {
        email: [{ validator: validateEmail, trigger: "blur" }],
        password: [{ validator: validatePsw, trigger: "blur" }],
        captcha: [{ validator: captcha, trigger: "blur" }]
      }
    };
  },
  computed: {
    logged() {
      //console.log(localStorage.token?true:false);
      return localStorage.token?true:false;
    },

    showReview() {
      if (this.$route.path.indexOf("/play/") >= 0) {
        return false;
      } else {
        return true;
      }
    },

    objectInfo() {
      return this.$store.getters.objectInfo;
    },

    commentList() {
      return this.$store.getters.commentList;
    },

    totalItems() {
      return this.$store.getters.commentList.length;
    }
  },
  watch: {},
  async created() {
    await this.fetch();
    this.checked = JSON.parse(localStorage.getItem("pk_user_remenber")) || false;
    //console.log("checked", this.checked);
    this.handleCurrentChange(this.currentPage);

    this.user = this.$store.getters.user;
  },
  methods: {
    async fetch() {
      let params = this.$route.query;
      let res = await this.$http.get("/comments", { params });
      this.$store.commit("UpdateCommentList", res.data.list);
      this.handleCurrentChange(this.currentPage);
    },

    async post() {
      if (!this.textarea) {
        this.$message({
          type: "error",
          // message:`请输入${this.showReview?"点评":"评论"}内容`
          message: `请输入评论内容`
        });
        return;
      }
      let params = {
        film_id: this.objectInfo.film_id,
        type_id: this.objectInfo.type_id,
        content: this.textarea
      };
      let res = await this.$http.post("/comments", { params });
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        this.$store.commit("UpdateCommentList", res.data.list);
        this.textarea = "";
        this.currentPage = 1;
        this.handleCurrentChange(this.currentPage);

        // const returnEle = document.querySelector("#comment"); //window是将要跳转区域的id
        // if (!!returnEle) {
        //   returnEle.scrollIntoView(true); // true 是默认的
        // }
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    },

    handleCurrentChange(val) {
      let pageList = [];
      for (
        let i = 5 * (val - 1);
        i < (5 * val < this.totalItems ? 5 * val : this.totalItems);
        i++
      ) {
        pageList.push(this.commentList[i]);
      }
      this.pageList = pageList;
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    },

    async login(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          let email = this.loginForm.email;
          let password = this.loginForm.password;
          let captcha = this.loginForm.captcha;

          let res = await this.$http.post("/login", {
            email,
            password,
            captcha
          });
          if (res.data.status == 200) {
            localStorage.token = res.data.token;

            let pk_user = {};
            pk_user.email = email;
            pk_user.password = password;
            let pk_user_remenber = this.checked;
            if (this.checked) {
              localStorage.setItem("pk_user", JSON.stringify(pk_user));
            } else {
              localStorage.removeItem("pk_user");
            }
            localStorage.setItem("pk_user_remenber", pk_user_remenber);
            this.dialogVisible = false;
            this.$router.go(0);
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
      // sessionStorage.setItem("pk_user",JSON.stringify(pk_user));
      // this.$router.push({path: '/login'})
    },

    async getCaptcha() {
      let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
      let email = this.loginForm.email;
      if (!email || !reg.test(email)) {
        this.$message.error("请输入正确的邮箱地址");
        return;
      } else {
        //console.log("eamil", email);
        let res = await this.$http.post("/getCaptcha", { email });
        //console.log("res", res);
        if (res.data.status == 200) {
          this.sendedCaptcha = true;
          sessionStorage.setItem("sendedCaptcha", this.sendedCaptcha);
          this.IntervalID = setInterval(() => {
            this.intervals--;
            // sessionStorage.setItem(this.intervals);
            //console.log(this.intervals);
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
  components: { CommentItem }
};
</script> 

<style lang='less' scoped>
.comment-box {
  margin-top: 20px;
  .tip {
    margin-top: 40px;
    font-size: 26px;
    font-weight: 400;
  }

  .space {
    margin-top: 40px;
    width: 100%;
    height: 50px;
    line-height: 50px;
    text-align: center;
  }

  .add-comment-wrap {
    margin-top: 30px;
    margin-bottom: 20px;
    .avatar {
      float: left;
      display: inline-block;
      width: 78px;
      height: 76px;
      overflow: hidden;
      border: 1px solid rgba(0, 0, 0, 0.1);
      border-radius: 5px;
      img {
        width: 100%;
        height: 100%;
      }
    }
    .text-area {
      margin-left: 20px;
      float: left;
      height: 75px;
    }

    .text-mask {
      text-align: center;
      font-size: 14px;
      margin-left: 20px;
      float: left;
      height: 76px;
      line-height: 76px;
      width: 962px;
      border-radius: 5px;
      background: rgba(192, 192, 192, 0.3);
      .el-button {
        padding: 4px 6px;
      }
    }

    .publish-button {
      float: right;
      .button-style {
        width: 80px;
        height: 75px;
        padding: 4px 20px;
        font-size: 18px;
        color: #fff;
        border-radius: 4px;
        text-align: center;
        min-width: 70px;
        vertical-align: top;
        cursor: pointer;
        background-color: #00a1d6;
        border: 1px solid #00a1d6;
        transition: 0.1s;
        user-select: none;
        outline: none;
      }
    }
  }

  .add-comment-wrap::after {
    content: "";
    display: block;
    clear: both;
    visibility: hidden;
  }

  .window-pagination {
    display: inline-block;
    margin-top: 30px;
    margin-left: 50%;
    transform: translateX(-50%);
  }

  .loginDialog{
  }

  .form {
    padding: 0 20px;
    padding-bottom: 40px;
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

    .item-wrap {
      position: relative;
      margin-bottom: 10px;
      width: 100%;
      height: 20px;
      font-size: 13px;
      .remember {
        position: absolute;
        left: 0;
        span {
          font-size: 13px;
          color: #bbbbbb;
        }

        span:nth-child(0n + 1) {
          margin-right: 8px;
          color: black;
        }
      }

      .forget-password {
        position: absolute;
        right: 0;
        color: #00a1d6;
      }
    }

    .button-wrap {
      width: 100%;
      position: relative;
      .login-button {
        position: absolute;
        width: 45%;
        left: 0;
      }

      .register-button {
        position: absolute;
        width: 45%;
        right: 0;
      }
    }
  }
}
</style>
