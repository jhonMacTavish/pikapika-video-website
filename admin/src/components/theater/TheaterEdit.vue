<template>
  <div>
    <h1>{{id?'编辑电影 ♥ '+this.model.th_name:'添加电影'}}</h1>
    <el-tabs v-model="activeName">
      <el-tab-pane label="基本信息" name="first" class="panel">
        <el-form
          :model="model"
          :rules="rules"
          ref="bangumi"
          label-width="200px"
          @submit.native.prevent="save"
          style="margin-right: 200px"
        >
          <el-form-item label="名称" prop="th_name">
            <el-input v-model="model.th_name" style="width:222px" maxlength="100"></el-input>
          </el-form-item>
          <el-form-item label="类型" prop="t_id">
            <el-select v-model="model.t_id" placeholder="请选择" disabled>
              <el-option
                v-for="item in types"
                :key="item.t_id"
                :label="item.text"
                :value="item.t_id"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="标签" prop="th_tag">
            <el-select v-model="model.th_tag" placeholder="请选择">
              <el-option v-for="item in tags" :key="item.id" :label="item.text" :value="item.id"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="画质" prop="th_VGA">
            <el-select v-model="model.th_VGA" placeholder="请选择">
              <el-option v-for="item in VGAs" :key="item.id" :label="item.text" :value="item.id"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="风格" prop="th_style">
            <!-- <el-select
          v-model="model.th_style"
          multiple
          filterable
          allow-create
          placeholder="请输入"
          :default-first-option="true"
          clearable
        >
          <el-option label="请编辑风格" value disabled></el-option>
            </el-select>-->
            <el-tag
              :key="tag"
              v-for="tag in model.th_style"
              closable
              :disable-transitions="false"
              @close="styHandleClose(tag)"
            >{{tag}}</el-tag>
            <el-input
              class="input-new-tag"
              v-if="styleVisible"
              v-model="styleValue"
              ref="saveStyleInput"
              size="small"
              @keyup.enter.native="styHandleInputConfirm"
              @blur="styHandleInputConfirm"
            ></el-input>
            <el-button v-else class="button-new-tag" size="small" @click="styShowInput">
              <i class="el-icon-plus"></i> 风格
            </el-button>
          </el-form-item>
          <el-form-item label="首字母" prop="th_initials">
            <el-select v-model="model.th_initials" placeholder="请选择">
              <el-option
                v-for="item in initials"
                :key="item.id"
                :label="item.text"
                :value="item.text"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="开播时间" prop="th_playtime">
            <el-date-picker
              v-model="model.th_playtime"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="演员" prop="th_actors">
            <!-- <el-select
          v-model="model.th_actors"
          multiple
          filterable
          allow-create
          placeholder="请输入"
          :default-first-option="true"
          clearable
        >
          <el-option label="请编辑演员" value disabled></el-option>
            </el-select>-->
            <el-tag
              :key="tag"
              v-for="tag in model.th_actors"
              closable
              :disable-transitions="false"
              @close="actHandleClose(tag)"
            >{{tag}}</el-tag>
            <el-input
              class="input-new-tag"
              v-if="actorsVisible"
              v-model="actorsValue"
              ref="saveActorInput"
              size="small"
              @keyup.enter.native="actHandleInputConfirm"
              @blur="actHandleInputConfirm"
            ></el-input>
            <el-button v-else class="button-new-tag" size="small" @click="actShowInput">
              <i class="el-icon-plus"></i> 演员
            </el-button>
          </el-form-item>
          <el-form-item label="图片地址" prop="th_imgSrc">
            <el-input v-model="model.th_imgSrc" maxlength="500"></el-input>
          </el-form-item>
          <el-form-item label="简介" prop="th_summary">
            <el-input type="textarea" rows="3" v-model="model.th_summary" clearable maxlength="500"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click.native="submitForm('bangumi')">保 存</el-button>
            <el-button @click="$router.push('/theater/list')">取 消</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="视频资源" name="second" class="panel">
        <el-button type="text" @click="addVideo" :disabled="true">
          <i class="el-icon-plus"></i>添加视频
        </el-button>
        <el-table :data="pageListV" stripe class="video-list">
          <!-- <el-table-column type="index" width="50"></el-table-column> -->
          <!-- <el-row type="flex" style="justify-content: space-between;"> -->
          <el-table-column type="index" width="50"></el-table-column>
          <el-table-column prop="r_episode" label="话数" width="130">
            <template slot-scope="scope">
              <div class="video-item">
                <span>第</span>
                <el-input
                  class="episode"
                  v-model="scope.row.r_episode"
                  maxlength="4"
                  onkeyup="value=value.replace(/[^\d\.]/g,'')"
                ></el-input>
                <span>话</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="r_address" label="视频地址">
            <template slot-scope="scope">
              <el-input v-model="scope.row.r_address"></el-input>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="200">
            <template slot-scope="scope">
              <div v-if="isAdding&&!scope.row.r_id">
                <el-button
                  type="text"
                  class="confirm-button"
                  icon="el-icon-check"
                  @click="confirmAdd(scope.row)"
                >确认</el-button>
                <el-button
                  type="text"
                  class="delete-button"
                  icon="el-icon-close"
                  @click="cancelAdd(scope.row)"
                >取消</el-button>
              </div>
              <div v-else>
                <el-button
                  v-if="scope.row.r_id"
                  type="text"
                  class="confirm-button"
                  icon="el-icon-edit-outline"
                  @click="update(scope.row)"
                >修改</el-button>
                <el-button
                  v-if="scope.row.r_id"
                  type="text"
                  class="delete-button"
                  icon="el-icon-delete"
                  @click="remove(scope.row)"
                >删除</el-button>
              </div>
            </template>
          </el-table-column>
          <!-- </el-row> -->
        </el-table>
        <div class="video-pagination">
          <el-pagination
            @current-change="videoCurrentChange"
            :current-page.sync="videoCurrentPage"
            :page-size="10"
            layout="total, prev, pager, next"
            :total="videoTotal"
            background
          ></el-pagination>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
export default {
  name: "BangumiEdit",
  props: {
    id: {}
  },
  data() {
    let th_name = (rule, value, callback) => {
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

    let th_tag = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择标签")); // 请输入番名
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let th_VGA = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入画质")); // 请输入番名
      } else {
        callback();
      }
    };

    let th_style = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧风格")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let th_initials = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请选择首字母")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let th_playtime = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择开播时间")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let th_actors = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧声优")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let th_imgSrc = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let th_summary = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请填写番剧简介")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      rules: {
        th_name: [{ validator: th_name, trigger: "blur" }],
        t_id: [{ validator: t_id, trigger: "change" }],
        th_tag: [{ validator: th_tag, trigger: "change" }],
        th_VGA: [{ validator: th_VGA, trigger: "blur" }],
        th_style: [{ validator: th_style, trigger: "change" }],
        th_initials: [{ validator: th_initials, trigger: "change" }],
        th_playtime: [{ validator: th_playtime, trigger: "blur" }],
        th_actors: [{ validator: th_actors, trigger: "change" }],
        th_imgSrc: [{ validator: th_imgSrc, trigger: "blur" }],
        th_summary: [{ validator: th_summary, trigger: "blur" }]
      },

      model: {
        th_name: "",
        t_id: 3,
        th_imgSrc: "",
        th_VGA: 1,
        th_tag: 1,
        th_style: [],
        th_initials: "",
        th_playtime: "",
        // th_quarter: "",
        th_years: "",
        th_actors: [],
        th_summary: ""
      },
      // model: {
      //   v_id: 0,
      //   t_id: 1,
      //   th_name: "",
      //   th_imgSrc: "",
      //   th_episodes: "",
      //   th_status: "",
      //   th_style: "",
      //   th_initials: "",
      //   th_playtime: "",
      //   th_quarter: "",
      //   th_years: "",
      //   th_actors: "",
      //   th_summary: "",
      //   play_volume: ""
      // },
      types: [],
      tags: [],
      VGAs: [],
      initials: [],

      styleVisible: false,
      styleValue: "",

      actorsVisible: false,
      actorsValue: "",

      pageListV: [],
      videoCurrentPage: 1,

      activeName: "first",
      newVideo: {
        r_episode: 0,
        r_address: ""
      },

      isAdding: false
    };
  },
  computed: {
    videoList() {
      return this.$store.getters.videoList;
    },

    videoTotal() {
      return this.$store.getters.videoList.length;
    }
  },
  watch: {},
  created() {
    this.id && this.fetch();

    this.types = this.$store.getters.types;
    this.tags = this.$store.getters.tags;
    this.VGAs = this.$store.getters.VGAs;
    this.initials = this.$store.getters.initials;
  },
  methods: {
    async update(row) {
      console.log("row", row);
      let params = {
        r_id: row.r_id,
        r_episode: row.r_episode,
        r_address: row.r_address
      };
      let res = await this.$http.put(`/videos/${this.id}`, params);
      console.log("delete", res);
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        this.fetch();
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    },

    async remove(row) {
      this.$confirm(`是否确定要删除番剧 "${row.b_name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          console.log("delete", `/videos/${row.r_id}`);
          const res = await this.$http.delete(`/videos/${row.r_id}`);
          console.log("delete", res);
          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            await this.fetch();
            this.videoCurrentChange(this.videoCurrentPage);
          } else {
            this.$message({
              type: "error",
              message: res.data.msg
            });
          }
        })
        .catch(() => {
          return;
        });
    },

    addVideo() {
      console.log("addVideo");
      this.isAdding = true;
      let r_episode = this.videoTotal + 1;
      this.newVideo.r_episode = r_episode;

      this.$store.commit("AddVideo", this.newVideo);
      this.videoCurrentPage = Math.ceil(this.videoTotal / 10);
      this.videoCurrentChange(this.videoCurrentPage);
    },

    cancelAdd() {
      if (!this.isAdding) return;
      this.$store.commit("DeleteVideo");
      this.isAdding = false;
      this.videoCurrentPage = Math.ceil(this.videoTotal / 10);
      this.videoCurrentChange(this.videoCurrentPage);
    },

    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          console.log("save");

          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);
          let timeSlice = params.th_playtime.split("-");
          params.th_years = timeSlice[0];

          params.th_style = params.th_style.join("、");
          params.th_actors = params.th_actors.join("、");
          console.log("params*************", params);

          let res;

          if (this.id) {
            console.log("更新");
            res = await this.$http.put(`/theaters/${this.id}`, params);
          } else {
            console.log("创建");
            res = await this.$http.post("/theaters", params);
          }

          console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/theater/list");
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
      let timeSlice = params.th_playtime.split("-");
      params.th_years = timeSlice[0];
      params.th_quarter = timeSlice[1];

      params.th_style = params.th_style.join("、");
      params.th_actors = params.th_actors.join("、");
      console.log("params*************", params);
      const res = await this.$http.post("/theaters", params);
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

    async fetch() {
      console.log("edit");
      const res = await this.$http.get(`/theaters/${this.id}`);
      console.log("res", res);

      res.data[0].th_style = res.data[0].th_style.split("、");
      res.data[0].th_actors = res.data[0].th_actors.split("、");

      this.model = res.data[0];
      console.log("this.model", this.model);
      let rst = await this.$http.get(`/videos/`, {
        params: { v_id: this.model.v_id, t_id: this.model.t_id }
      });
      this.$store.dispatch("updateVideofoList", rst.data.list);
      
      if (Math.ceil(this.videoTotal / 10) < this.videoCurrentPage) {
        --this.videoCurrentPage;
      }

      this.videoCurrentChange(this.videoCurrentPage);
      console.log("this.videoList", this.videoList);
    },

    styHandleClose(tag) {
      this.model.th_style.splice(this.model.th_style.indexOf(tag), 1);
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
        this.model.th_style.push(styleValue);
      }

      this.styleVisible = false;
      this.styleValue = "";
    },

    actHandleClose(tag) {
      this.model.th_actors.splice(this.model.th_actors.indexOf(tag), 1);
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
        this.model.th_actors.push(actorsValue);
      }
      this.actorsVisible = false;
      this.actorsValue = "";
    },

    videoCurrentChange(val) {
      if (val < 1) {
        val = 1;
      }
      let pageList = [];
      for (
        let i = 10 * (val - 1);
        i < (10 * val < this.videoTotal ? 10 * val : this.videoTotal);
        i++
      ) {
        pageList.push(this.videoList[i]);
      }
      this.pageListV = pageList;
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

.panel {
  position: relative;
  padding-bottom: 60px;
  // overflow: auto;
}

.video-item {
  display: flex;
  justify-content: space-between;
  span {
    width: 20px;
    display: inline-block;
    height: 40px;
    line-height: 40px;
  }

  .episode {
    // margin-left: -20px;
    // margin-right: -20px;
    width: 62px;
  }
}

.delete-button {
  color: #f56c6c;
  margin-right: 20px;
  padding: 0;
  width: 40px;
  height: 40px;
}

.confirm-button {
  // margin-left: 18px;
  color: #67c23a;
}
</style>
