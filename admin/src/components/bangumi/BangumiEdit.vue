<template>
  <div>
    <h1>{{id?'编辑':'添加'}}番剧</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="bangumi"
      label-width="120px"
      @submit.native.prevent="save"
      style="margin-right: 100px"
    >
      <el-form-item label="名称" prop="b_name">
        <el-input v-model="model.b_name" style="width:222px" maxlength="100"></el-input>
      </el-form-item>
      <el-form-item label="类型" prop="t_id">
        <el-select v-model="model.t_id" placeholder="请选择" :disabled="!id">
          <el-option v-for="item in types" :key="item.t_id" :label="item.text" :value="item.t_id"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="总集数" prop="b_episodes">
        <el-input v-model="model.b_episodes" style="width:222px" maxlength="4"></el-input>
      </el-form-item>
      <el-form-item label="状态" prop="b_status">
        <el-select v-model="model.b_status" placeholder="请选择">
          <el-option v-for="(item) in status" :key="item.id" :label="item.text" :value="item.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="风格" prop="b_style">
        <el-select
          v-model="model.b_style"
          multiple
          filterable
          allow-create
          placeholder="请输入"
          :default-first-option="true"
          clearable
        >
          <el-option label="请编辑风格" value disabled></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="首字母" prop="b_initials">
        <el-select v-model="model.b_initials" placeholder="请选择">
          <el-option v-for="item in initials" :key="item.id" :label="item.text" :value="item.text"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="开播时间" prop="b_playtime">
        <el-date-picker
          v-model="model.b_playtime"
          type="date"
          placeholder="选择日期"
          value-format="yyyy-MM-dd"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="声优" prop="b_actors">
        <el-select
          v-model="model.b_actors"
          multiple
          filterable
          allow-create
          placeholder="请输入"
          :default-first-option="true"
          clearable
        >
          <el-option label="请编辑声优" value disabled></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="图片地址" prop="b_imgSrc">
        <el-input v-model="model.b_imgSrc" maxlength="500"></el-input>
      </el-form-item>
      <el-form-item label="简介" prop="b_summary">
        <el-input type="textarea" rows="3" v-model="model.b_summary" clearable maxlength="500"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click.native="submitForm('bangumi')">保存</el-button>
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
    let b_name = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入番名")); // 请输入番名
      } else {
        callback();
      }
    };

    let t_id = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择类型")); // 请输入番名
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let b_episodes = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入集数")); // 请输入请输入集数
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let b_status = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入集数")); // 请输入请输入集数
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let b_style = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧风格")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let b_initials = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请选择首字母")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let b_playtime = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择开播时间")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let b_actors = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧声优")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let b_imgSrc = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let b_summary = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请填写番剧简介")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      rules: {
        b_name: [{ validator: b_name, trigger: "blur" }],
        t_id: [{ validator: t_id, trigger: "change" }],
        b_episodes: [{ validator: b_episodes, trigger: "blur" }],
        b_status: [{ validator: b_status, trigger: "change" }],
        b_style: [{ validator: b_style, trigger: "change" }],
        b_initials: [{ validator: b_initials, trigger: "change" }],
        b_playtime: [{ validator: b_playtime, trigger: "blur" }],
        b_actors: [{ validator: b_actors, trigger: "change" }],
        b_imgSrc: [{ validator: b_imgSrc, trigger: "blur" }],
        b_summary: [{ validator: b_summary, trigger: "blur" }]
      },

      model: {
        b_name: "",
        t_id: 1,
        b_imgSrc: "",
        b_episodes: "",
        b_status: 2,
        b_style: [],
        b_initials: "",
        b_playtime: "",
        b_quarter: "",
        b_years: "",
        b_actors: [],
        b_summary: ""
      },
      // model: {
      //   v_id: 0,
      //   t_id: 1,
      //   b_name: "",
      //   b_imgSrc: "",
      //   b_episodes: "",
      //   b_status: "",
      //   b_style: "",
      //   b_initials: "",
      //   b_playtime: "",
      //   b_quarter: "",
      //   b_years: "",
      //   b_actors: "",
      //   b_summary: "",
      //   play_volume: ""
      // },
      types: [],
      status: [],
      initials: [],
      playtime: ""
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
          let timeSlice = params.b_playtime.split("-");
          params.b_years = timeSlice[0];
          params.b_quarter = timeSlice[1];

          params.b_style = params.b_style.join("、");
          params.b_actors = params.b_actors.join("、");
          console.log("params*************", params);
          const res = await this.$http.post("/bangumis", params);
          console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/bangumi/list");
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
      let timeSlice = params.b_playtime.split("-");
      params.b_years = timeSlice[0];
      params.b_quarter = timeSlice[1];

      params.b_style = params.b_style.join("、");
      params.b_actors = params.b_actors.join("、");
      console.log("params*************", params);
      const res = await this.$http.post("/bangumis", params);
      console.log("res***********", res);

      if (res.affectedRows === 1) {
        this.$message({
          type: "success",
          message: res.msg
        });
        this.$router.push("/bangumi/list");
      } else {
        this.$message({
          type: "error",
          message: res.msg
        });
      }
    },

    async featch() {
      console.log("edit");
      const res = await this.$http.get(`/bangumis/${this.id}`);
      // console.log("res", res.data[0].b_style.split("、"));

      res.data[0].b_style = res.data[0].b_style.split("、");
      res.data[0].b_actors = res.data[0].b_actors.split("、");

      this.model = res.data[0];
      console.log("this.model", this.model);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
</style>
