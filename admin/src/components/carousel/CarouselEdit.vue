<template>
  <div>
    <h1>{{carousel_id?'编辑':'添加'}}轮播图</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="carousel"
      label-width="200px"
      style="margin-right: 200px"
    >
      <el-form-item label="类型" prop="type_id">
        <el-select v-model="model.type_id" placeholder="请选择" @change="changeTypeID">
          <el-option
            v-for="item in types"
            :key="item.type_id"
            :label="item.text"
            :value="item.type_id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="番名" prop="film_id">
        <el-select v-model="model.film_id" filterable placeholder="请选择" @change="getEpisodes">
          <el-option
            v-for="item in filmNames"
            :key="item.film_id"
            :label="item.name"
            :value="item.film_id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="章节" prop="episode">
        <el-input
          type="text"
          v-model="model.episode"
          style="width:222px"
          maxlength="4"
          :disabled="true"
        >
          <template slot="prefix">第</template>
          <template slot="suffix">话</template>
        </el-input>
      </el-form-item>
      <el-form-item label="图片地址" prop="imgSrc">
        <el-input v-model="model.imgSrc" maxlength="500"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click.native="submitForm('carousel')">保 存</el-button>
        <el-button @click="$router.push('/carousel/list')">取 消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "BangumiEdit",
  props: {
    carousel_id: null
  },
  data() {
    let type_id = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入番名")); // 请输入番名
      } else {
        callback();
      }
    };

    let film_id = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择番名"));
      } else {
        callback();
      }
    };

    let episode = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请先添加视频资源")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let imgSrc = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      rules: {
        type_id: [{ validator: type_id, trigger: "change" }],
        film_id: [{ validator: film_id, trigger: "change" }],
        episode: [{ validator: episode, trigger: "change" }],
        imgSrc: [{ validator: imgSrc, trigger: "blur" }]
      },

      filmNames: [],

      model: {
        type_id: 1,
        film_id: null,
        episode: null,
        imgSrc: ""
      },

      styleVisible: false,
      styleValue: "",

      actorsVisible: false,
      actorsValue: ""
    };
  },
  computed: {
    types() {
      let types = this.$store.getters.types;
      types.length = 2;
      return types;
    }
  },
  watch: {},
  created() {
    this.carousel_id ? this.fetch() : this.updatingFilms();
  },
  methods: {
    async changeTypeID(type_id) {
      this.model.type_id = type_id;
      this.model.film_id = null;
      this.model.episode = null;
      await this.updatingFilms();
    },

    async getEpisodes(film_id) {
      let { type_id } = this.model;
      //console.log("type_id", type_id);
      let params = { type_id, film_id };
      let res = await this.$http.get("/episodes", { params });
      this.model.episode = res.data.episodes;
      //console.log("res", res);
    },

    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          //console.log("save");

          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);

          let res;

          if (this.carousel_id) {
            //console.log("更新");
            res = await this.$http.put(
              `/carousels/${this.carousel_id}`,
              params
            );
          } else {
            //console.log("创建");
            res = await this.$http.post("/carousels", params);
          }

          //console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/carousel/list");
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

    async updatingFilms() {
      const res = await this.$http.get(`/updatingfilm/${this.model.type_id}`);
      //console.log("res", res);
      this.filmNames = res.data.list;
      //console.log("filmNames", this.filmNames);
    },

    async fetch() {
      const res = await this.$http.get(`/carousels/${this.carousel_id}`);
      //console.log("res", res);
      if (res.data.list[0]) {
        this.model = res.data.list[0];
        this.filmNames = res.data.filmNames;
      }
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
