<template>
  <div>
    <h1>{{id?'编辑':'添加'}}国漫</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="guoman"
      label-width="120px"
      @submit.native.prevent="save"
      style="margin-right: 100px"
    >
      <el-form-item label="名称" prop="g_name">
        <el-input v-model="model.g_name" style="width:222px" maxlength="100"></el-input>
      </el-form-item>
      <el-form-item label="类型" prop="t_id">
        <el-select v-model="model.t_id" placeholder="请选择" :disabled="!id">
          <el-option v-for="item in types" :key="item.t_id" :label="item.text" :value="item.t_id"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="总集数" prop="g_episodes">
        <el-input v-model="model.g_episodes" style="width:222px" maxlength="4"></el-input>
      </el-form-item>
      <el-form-item label="状态" prop="g_status">
        <el-select v-model="model.g_status" placeholder="请选择">
          <el-option v-for="(item) in status" :key="item.id" :label="item.text" :value="item.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="风格" prop="g_style">
        <el-select
          v-model="model.g_style"
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
      <el-form-item label="首字母" prop="g_initials">
        <el-select v-model="model.g_initials" placeholder="请选择">
          <el-option v-for="item in initials" :key="item.id" :label="item.text" :value="item.text"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="开播时间" prop="g_playtime">
        <el-date-picker
          v-model="model.g_playtime"
          type="date"
          placeholder="选择日期"
          value-format="yyyy-MM-dd"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="声优" prop="g_actors">
        <el-select
          v-model="model.g_actors"
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
      <el-form-item label="图片地址" prop="g_imgSrc">
        <el-input v-model="model.g_imgSrc" maxlength="500"></el-input>
      </el-form-item>
      <el-form-item label="简介" prop="g_summary">
        <el-input type="textarea" rows="3" v-model="model.g_summary" clearable maxlength="500"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click.native="submitForm('guoman')">保 存</el-button>
        <el-button @click="$router.go(-1)">取 消</el-button>
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
    let g_name = (rule, value, callback) => {
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

    let g_episodes = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入集数")); // 请输入请输入集数
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let g_status = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入集数")); // 请输入请输入集数
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let g_style = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧风格")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let g_initials = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请选择首字母")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let g_playtime = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择开播时间")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let g_actors = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧声优")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let g_imgSrc = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let g_summary = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请填写番剧简介")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      rules: {
        g_name: [{ validator: g_name, trigger: "blur" }],
        t_id: [{ validator: t_id, trigger: "change" }],
        g_episodes: [{ validator: g_episodes, trigger: "blur" }],
        g_status: [{ validator: g_status, trigger: "change" }],
        g_style: [{ validator: g_style, trigger: "change" }],
        g_initials: [{ validator: g_initials, trigger: "change" }],
        g_playtime: [{ validator: g_playtime, trigger: "blur" }],
        g_actors: [{ validator: g_actors, trigger: "change" }],
        g_imgSrc: [{ validator: g_imgSrc, trigger: "blur" }],
        g_summary: [{ validator: g_summary, trigger: "blur" }]
      },

      model: {
        g_name: "",
        t_id: 2,
        g_imgSrc: "",
        g_episodes: "",
        g_status: 1,
        g_style: [],
        g_initials: "",
        g_playtime: "",
        // g_quarter: "",
        g_years: "",
        g_actors: [],
        g_summary: ""
      },
      // model: {
      //   v_id: 0,
      //   t_id: 1,
      //   g_name: "",
      //   g_imgSrc: "",
      //   g_episodes: "",
      //   g_status: "",
      //   g_style: "",
      //   g_initials: "",
      //   g_playtime: "",
      //   g_quarter: "",
      //   g_years: "",
      //   g_actors: "",
      //   g_summary: "",
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
          let timeSlice = params.g_playtime.split("-");
          params.g_years = timeSlice[0];
          // params.g_quarter = timeSlice[1];

          params.g_style = params.g_style.join("、");
          params.g_actors = params.g_actors.join("、");
          console.log("params*************", params);

          let res;

          if (this.id) {
            console.log("更新");
            res = await this.$http.put(`/guomans/${this.id}`, params);
          } else {
            console.log("创建");
            res = await this.$http.post("/guomans", params);
          }

          console.log("res***********", res);
          
          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/guoman/list");
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
      let timeSlice = params.g_playtime.split("-");
      params.g_years = timeSlice[0];
      // params.g_quarter = timeSlice[1];

      params.g_style = params.g_style.join("、");
      params.g_actors = params.g_actors.join("、");
      console.log("params*************", params);
      const res = await this.$http.post("/guomans", params);
      console.log("res***********", res);

      if (res.affectedRows === 1) {
        this.$message({
          type: "success",
          message: res.msg
        });
        this.$router.push("/guoman/list");
      } else {
        this.$message({
          type: "error",
          message: res.msg
        });
      }
    },

    async featch() {
      console.log("edit");
      const res = await this.$http.get(`/guomans/${this.id}`);
      // console.log("res", res.data[0].g_style.split("、"));

      res.data[0].g_style = res.data[0].g_style.split("、");
      res.data[0].g_actors = res.data[0].g_actors.split("、");

      this.model = res.data[0];
      console.log("this.model", this.model);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
</style>
