<template>
  <div>
    <h1>{{id?'编辑':'添加'}}用户</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="userinfo"
      label-width="200px"
      @submit.native.prevent="save"
      style="margin-right: 200px"
    >
      <el-form-item label="名称" prop="u_name">
        <el-input v-model="model.u_name" style="width:222px" maxlength="48"></el-input>
      </el-form-item>

      <el-form-item label="邮箱" prop="u_email">
        <el-input v-model="model.u_email" style="width:222px" maxlength="100"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="u_password">
        <el-input type="password" v-model="model.u_password" style="width:222px" maxlength="16"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="u_sex">
        <template>
          <el-radio-group v-model="model.u_sex">
            <el-radio :label="0">男</el-radio>
            <el-radio :label="1">女</el-radio>
          </el-radio-group>
        </template>
      </el-form-item>

      <el-form-item label="头像地址" prop="u_avatar">
        <el-input v-model="model.u_avatar" maxlength="500"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click.native="submitForm('userinfo')">保 存</el-button>
        <el-button @click="$router.push('/userinfo/list')">取 消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "BangumiEdit",
  props: {
    id: {}
  },
  data() {
    let u_name = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入番名")); // 请输入番名
      } else {
        callback();
      }
    };

    let u_email = (rule, value, callback) => {
      let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
      if (!value) {
        callback(new Error("请输入邮箱")); // 请输入请输入集数
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("请输入正确的邮箱格式"));
      }
    };

    let u_password = (rule, value, callback) => {
      let reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
      if (!value) {
        callback(new Error("请输入密码")); // 请输入请输入集数
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("密码由字母数字下划线组成的16位字符串"));
      }
    };

    let u_avatar = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let u_summary = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请填写番剧简介")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      rules: {
        u_name: [{ validator: u_name, trigger: "blur" }],
        u_email: [{ validator: u_email, trigger: "blur" }],
        u_password: [{ validator: u_password, trigger: "blur" }],
        u_avatar: [{ validator: u_avatar, trigger: "blur" }],
        u_summary: [{ validator: u_summary, trigger: "blur" }]
      },

      model: {
        u_name: "",
        u_email: "",
        u_password: "",
        u_sex: 0,
        u_avatar: ""
      },
      // model: {
      //   v_id: 0,
      //   t_id: 1,
      //   u_name: "",
      //   u_imgSrc: "",
      //   u_episodes: "",
      //   u_status: "",
      //   u_style: "",
      //   u_initials: "",
      //   u_playtime: "",
      //   u_quarter: "",
      //   u_years: "",
      //   u_actors: "",
      //   u_summary: "",
      //   play_volume: ""
      // },
      types: [],
      status: [],
      initials: [],

      styleVisible: false,
      styleValue: "",

      actorsVisible: false,
      actorsValue: ""
    };
  },
  computed: {},
  watch: {},
  created() {
    this.id && this.featch();

    this.types = this.$store.getters.types;
    this.status = this.$store.getters.status;
    this.initials = this.$store.getters.initials;
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          console.log("save");

          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);

          let res;

          if (this.id) {
            console.log("更新");
            res = await this.$http.put(`/userinfos/${this.id}`, params);
          } else {
            console.log("创建");
            res = await this.$http.post("/userinfos", params);
          }

          console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/userinfo/list");
          } else {
            this.$message({
              type: "error",
              message: res.data.msg
            });
          }
        } else {
          this.$message({
            type: "error",
            message: "请将表格填写完整"
          });
          return false;
        }
      });
    },

    async save() {
      console.log("save");
      var objString = JSON.stringify(this.model);
      var params = JSON.parse(objString);

      console.log("params*************", params);
      const res = await this.$http.post("/userinfos", params);
      console.log("res***********", res);

      if (res.affectedRows === 1) {
        this.$message({
          type: "success",
          message: res.msg
        });
        this.$router.push("/userinfo/list");
      } else {
        this.$message({
          type: "error",
          message: res.msg
        });
      }
    },

    async featch() {
      console.log("edit");
      const res = await this.$http.post(`/userinfos/${this.id}`);

      this.model = res.data[0];
      console.log("this.model", this.model);
    },

    styHandleClose(tag) {
      this.model.u_style.splice(this.model.u_style.indexOf(tag), 1);
    },

    styShowInput() {
      this.styleVisible = true;
      this.$nextTick(_ => {
        this.$refs.saveStyleInput.$refs.input.focus();
      });
    },

    styHandleInputConfirm() {
      let styleValue = this.styleValue;
      if (styleValue) {
        this.model.u_style.push(styleValue);
      }

      this.styleVisible = false;
      this.styleValue = "";
    },

    actHandleClose(tag) {
      this.model.u_actors.splice(this.model.u_actors.indexOf(tag), 1);
    },

    actShowInput() {
      this.actorsVisible = true;
      this.$nextTick(_ => {
        this.$refs.saveActorInput.$refs.input.focus();
      });
    },

    actHandleInputConfirm() {
      let actorsValue = this.actorsValue;
      if (actorsValue) {
        this.model.u_actors.push(actorsValue);
      }
      this.actorsVisible = false;
      this.actorsValue = "";
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.el-tag {
  margin-right: 10px;
}
.button-new-tag {
  // margin-left: 10px;
  height: 32px;
  line-height: 30px;
  padding-top: 0;
  padding-bottom: 0;
}
.input-new-tag {
  position: relative;
  bottom: -1px;
  width: 90px;
  // margin-left: 10px;
  vertical-align: bottom;
}
</style>
