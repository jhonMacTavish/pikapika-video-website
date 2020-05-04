<template>
  <div>
    <h1>{{id?'编辑番剧 ♥ '+this.modelB.b_name:'添加番剧'}}</h1>

    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="基本信息" name="first" class="panel">
        <el-form
          :model="modelB"
          :rules="rules"
          ref="basicInfo"
          label-width="190px"
          @submit.native.prevent="save"
          style="padding-right: 60px;margin-top:60px"
        >
          <el-form-item label="名称" prop="b_name">
            <el-input v-model="modelB.b_name" style="width:222px" maxlength="100"></el-input>
          </el-form-item>
          <el-form-item label="类型" prop="t_id">
            <el-select v-model="modelB.t_id" placeholder="请选择" disabled>
              <el-option
                v-for="item in types"
                :key="item.t_id"
                :label="item.text"
                :value="item.t_id"
              ></el-option>
            </el-select>
          </el-form-item>

          <!-- <el-form-item label="总集数" prop="b_episodes">
            <el-input v-model="modelB.b_episodes" style="width:222px" maxlength="4"></el-input>
          </el-form-item>-->
          <el-form-item label="状态" prop="b_status">
            <el-select v-model="modelB.b_status" placeholder="请选择">
              <el-option
                v-for="(item) in status"
                :key="item.id"
                :label="item.text"
                :value="item.id"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="风格" prop="b_style">
            <!-- <el-select
              v-model="modelB.b_style"
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
              v-for="tag in modelB.b_style"
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
          <el-form-item label="首字母" prop="b_initials">
            <el-select v-model="modelB.b_initials" placeholder="请选择">
              <el-option
                v-for="item in initials"
                :key="item.id"
                :label="item.text"
                :value="item.text"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="开播时间" prop="b_playtime">
            <el-date-picker
              v-model="modelB.b_playtime"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="声优" prop="b_actors">
            <!-- <el-select
              v-model="modelB.b_actors"
              multiple
              filterable
              allow-create
              placeholder="请输入"
              :default-first-option="true"
              clearable
            >
            <el-option label="请编辑声优" value disabled></el-option>
            </el-select>-->
            <el-tag
              :key="tag"
              v-for="tag in modelB.b_actors"
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
              <i class="el-icon-plus"></i> 声优
            </el-button>
          </el-form-item>
          <el-form-item label="图片地址" prop="b_imgSrc">
            <el-input v-model="modelB.b_imgSrc" maxlength="500"></el-input>
          </el-form-item>
          <el-form-item label="简介" prop="b_summary">
            <el-input type="textarea" rows="4" v-model="modelB.b_summary" clearable maxlength="500"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click.native="submitForm('basicInfo')">保 存</el-button>
            <el-button @click="$router.push('/bangumi/list')">取 消</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>
      <el-tab-pane v-if="id" label="视频资源" name="second" class="panel">
        <el-button type="text" @click="addVideo" :disabled="isAdding">
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
                  :disabled="isAdding"
                >修改</el-button>
                <el-button
                  v-if="scope.row.r_id"
                  type="text"
                  class="delete-button"
                  icon="el-icon-delete"
                  @click="remove(scope.row)"
                  :disabled="isAdding"
                >删除</el-button>
              </div>
            </template>
          </el-table-column>
          <!-- </el-row> -->
        </el-table>
        <el-button type="danger" @click="$router.push('/bangumi/list')">关 闭</el-button>
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
      <el-tab-pane v-if="id" label="评论信息" name="third" class="panel">
        <el-table :data="pageListC" strike style="margin-top:40px">
          <el-table-column type="index" width="50px"></el-table-column>
          <el-table-column prop="c_uname" label="用户名" width="150">
            <template slot-scope="scope">
              <el-button
                type="text"
                class="detail-button"
                @click="userDetail(scope.row)"
              >{{scope.row.c_uname}}</el-button>
            </template>
          </el-table-column>
          <el-table-column prop="c_uavatar" label="用户头像" width="100"></el-table-column>
          <el-table-column prop="c_content" label="评论内容" width="500"></el-table-column>
          <el-table-column prop="create_time" label="评论时间" width="230" fixed="right"></el-table-column>
          <el-table-column label="操作" width="200" fixed="right">
            <template slot-scope="scope">
              <el-button
                type="text"
                class="detail-button"
                icon="el-icon-edit-outline"
                @click="commentDetail(scope.row)"
              >查看</el-button>
              <el-button
                type="text"
                class="delete-button"
                icon="el-icon-delete"
                @click="commentRemove(scope.row)"
              >删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <el-button type="danger" @click="$router.push('/bangumi/list')">关 闭</el-button>
        <div class="video-pagination">
          <el-pagination
            @current-change="commentCurrentChange"
            :current-page.sync="commentCurrentPage"
            :page-size="10"
            layout="total, prev, pager, next"
            :total="commentTotal"
            background
          ></el-pagination>
        </div>
      </el-tab-pane>
    </el-tabs>
    <el-dialog title="评论信息" :visible.sync="dialogFormVisibleC">
      <el-form :model="modelC" label-width="100px">
        <el-form-item label="用户名" class="form-item">
          <p>{{modelC.c_uname}}</p>
        </el-form-item>
        <el-form-item label="用户头像" class="form-item">
          <p>{{modelC.c_uavatar}}</p>
        </el-form-item>
        <el-form-item label="评论内容" class="form-item">
          <p>{{modelC.c_content}}</p>
        </el-form-item>
        <el-form-item label="评论时间" class="form-item">
          <p>{{modelC.create_time}}</p>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisibleC = false" class="close">关 闭</el-button>
      </div>
    </el-dialog>
    <el-dialog title="用户信息" :visible.sync="dialogFormVisibleU">
      <el-form :model="modelU" label-width="100px">
        <el-form-item label="用户名" class="form-item">
          <p>{{modelU.u_name}}</p>
        </el-form-item>
        <el-form-item label="用户头像" class="form-item">
          <p>{{modelU.u_avatar}}</p>
        </el-form-item>
        <el-form-item label="性别" class="form-item">
          <p>{{modelU.u_sex==1?"女":"男"}}</p>
        </el-form-item>
        <el-form-item label="邮箱" class="form-item">
          <p>{{modelU.u_email}}</p>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisibleU = false" class="close">关 闭</el-button>
      </div>
    </el-dialog>
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
      } else if (value.join("").length > 50) {
        callback(new Error("字符数不能大于50"));
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
      } else if (value.length > 10) {
        callback(new Error("请选择正确的时间格式：yyyy-mm-dd"));
      } else {
        callback();
      }
    };

    let b_actors = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧声优")); // 请输入请输入集数
      } else if (value.join("").length > 255) {
        callback(new Error("字符数不能大于255"));
      } else {
        callback();
      }
    };

    let b_imgSrc = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else if (value.length > 500) {
        callback(new Error("图片路径字符数不能大于500"));
      } else {
        callback();
      }
    };

    let b_summary = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请填写番剧简介")); // 请输入请输入集数
      } else if (value.length > 500) {
        callback(new Error("简介字符数不能大于500"));
      } else {
        callback();
      }
    };

    return {
      input: "",

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

      modelB: {
        b_name: "",
        t_id: 1,
        b_imgSrc: "",
        b_episodes: "",
        b_status: 1,
        b_style: [],
        b_initials: "",
        b_playtime: "",
        b_quarter: "",
        b_years: "",
        b_actors: [],
        b_summary: ""
      },
      types: [],
      status: [],
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

      isAdding: false,

      pageListC: [],
      commentCurrentPage: 1,

      dialogFormVisibleC: false,
      dialogFormVisibleU: false,

      modelC: {},
      modelU: {}
    };
  },
  computed: {
    videoList() {
      return this.$store.getters.videoList;
    },

    videoTotal() {
      return this.$store.getters.videoList.length;
    },

    commentList() {
      return this.$store.getters.commentList;
    },

    commentTotal() {
      return this.$store.getters.commentList.length;
    }
  },
  watch: {},
  created() {
    this.id && this.fetch();

    this.types = this.$store.getters.types;
    this.status = this.$store.getters.status;
    this.initials = this.$store.getters.initials;
  },
  methods: {
    async userDetail(row) {
      const res = await this.$http.post(`/userinfos/${row.c_uid}`);
      this.modelU = res.data[0];
      this.dialogFormVisibleU = true;
      console.log("this.modelU", this.modelU);
    },

    async commentRemove(row) {
      let res = await this.$http.delete(`/comments/${row.c_id}`);

      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        await this.fetchComment();
        this.commentCurrentPage = Math.ceil(this.commentTotal / 10);
        this.commentCurrentChange(this.commentCurrentPage);
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    },

    commentDetail(row) {
      this.modelC = row;
      console.log("modelC", this.modelC);
      this.dialogFormVisibleC = true;
    },

    async update(row) {
      console.log("isAdding", this.isAdding);

      if (this.isAdding) {
        this.$message({
          type: "error",
          msg: "请先完成或取消添加视频"
        });
        return;
      }

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
        this.fetchVideo();
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    },

    async remove(row) {
      console.log("isAdding", this.isAdding);
      if (this.isAdding) {
        this.$message({
          type: "error",
          msg: "请先完成或取消添加视频"
        });
        return;
      }
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
            await this.fetchVideo();
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

    async confirmAdd(row) {
      if (!this.isAdding) return;
      console.log("confirmAdd", row);
      this.$store.commit("DeleteVideo");
      let params = this.newVideo;
      console.log("params", params);
      params.r_episode = Number(params.r_episode);
      params.v_id = this.modelB.v_id;
      params.t_id = this.modelB.t_id;

      let res = await this.$http.post("/videos", params);
      console.log("rst", res);

      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        await this.fetchVideo();
        this.isAdding = false;
        this.videoCurrentPage = Math.ceil(this.videoTotal / 10);
        this.videoCurrentChange(this.videoCurrentPage);
        this.newVideo = {
          r_episode: 0,
          r_address: ""
        };
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    },

    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          console.log("save");

          var objString = JSON.stringify(this.modelB);
          var params = JSON.parse(objString);
          let timeSlice = params.b_playtime.split("-");
          params.b_years = timeSlice[0];
          params.b_quarter = timeSlice[1];

          params.b_style = params.b_style.join("、");
          params.b_actors = params.b_actors.join("、");
          console.log("params*************", params);

          let res;

          if (this.id) {
            console.log("更新");
            res = await this.$http.put(`/bangumis/${this.id}`, params);
          } else {
            console.log("创建");
            res = await this.$http.post("/bangumis", params);
            console.log("创建res", res);
          }

          console.log("res***********", res);

          if (res.data.status == 200) {
            // this.$message({
            //   type: "success",
            //   message: res.data.msg
            // });
            if (!this.id) {
              this.$confirm(
                `${res.data.msg},是否添加"${params.b_name}"的视频资源?`,
                "提示",
                {
                  confirmButtonText: "确定",
                  cancelButtonText: "取消",
                  type: "success"
                }
              )
                .then(async () => {
                  this.id = res.data.v_id;
                  await this.fetch();
                  await this.fetchVideo();
                  await this.fetchComment();
                  this.activeName = "second";
                })
                .catch(() => {
                  this.$router.push("/bangumi/list");
                });
            } else {
              this.$message({
                type: "success",
                message: res.data.msg
              });
              this.$router.push("/bangumi/list");
            }
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
      var objString = JSON.stringify(this.modelB);
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

    async fetch() {
      // console.log("this.videoCurrentPage", this.videoCurrentPage);

      console.log("edit");
      const resB = await this.$http.get(`/bangumis/${this.id}`);
      // console.log("resB", resB.data[0].b_style.split("、"));

      resB.data[0].b_style = resB.data[0].b_style.split("、");
      resB.data[0].b_actors = resB.data[0].b_actors.split("、");

      this.modelB = resB.data[0];

      // let resV = await this.$http.get(`/videos/`, {
      //   params: { v_id: this.modelB.v_id, t_id: this.modelB.t_id }
      // });
      // console.log("resV.data.list", resV.data.list);
      // // this.$store.dispatch("updateVideoList", resV.data.list);
      // this.$store.commit("UpdateVideoList", resV.data.list);

      // this.videoCurrentChange(this.videoCurrentPage);

      // let resC = await this.$http.get(`/comments/`, {
      //   params: { v_id: this.modelB.v_id, t_id: this.modelB.t_id }
      // });

      // console.log("resC", resC.data.list);
      // this.$store.commit("UpdateCommentList", resC.data.list);
      // this.commentCurrentChange(this.commentCurrentPage);
    },

    async fetchVideo() {
      let resV = await this.$http.get(`/videos/`, {
        params: { v_id: this.modelB.v_id, t_id: this.modelB.t_id }
      });
      console.log("resV.data.list", resV.data.list);
      // this.$store.dispatch("updateVideoList", resV.data.list);
      this.$store.commit("UpdateVideoList", resV.data.list);

      this.videoCurrentChange(this.videoCurrentPage);
    },

    async fetchComment() {
      let resC = await this.$http.get(`/comments/`, {
        params: { v_id: this.modelB.v_id, t_id: this.modelB.t_id }
      });

      console.log("resC", resC.data.list);
      this.$store.commit("UpdateCommentList", resC.data.list);
      this.commentCurrentChange(this.commentCurrentPage);
    },

    styHandleClose(tag) {
      this.modelB.b_style.splice(this.modelB.b_style.indexOf(tag), 1);
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
        this.modelB.b_style.push(styleValue);
      }

      this.styleVisible = false;
      this.styleValue = "";
    },

    actHandleClose(tag) {
      this.modelB.b_actors.splice(this.modelB.b_actors.indexOf(tag), 1);
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
        this.modelB.b_actors.push(actorsValue);
      }
      this.actorsVisible = false;
      this.actorsValue = "";
    },

    videoCurrentChange(val) {
      console.log("this.videoTotal", this.videoTotal);
      if (Math.ceil(this.videoTotal / 10) < this.videoCurrentPage) {
        --this.videoCurrentPage;
      }

      if (val < 1) {
        val = 1;
      }
      console.log("this.videoCurrentPage", this.videoCurrentPage);
      let pageList = [];
      for (
        let i = 10 * (val - 1);
        i < (10 * val < this.videoTotal ? 10 * val : this.videoTotal);
        i++
      ) {
        pageList.push(this.videoList[i]);
      }
      this.pageListV = pageList;
      console.log("this.pageListV", this.pageListV);
    },

    commentCurrentChange(val) {
      console.log("this.commentTotal", this.commentTotal);
      if (Math.ceil(this.videoTotal / 10) < this.commentCurrentPage) {
        --this.commentCurrentPage;
      }

      if (val < 1) {
        val = 1;
      }
      console.log("this.commentCurrentPage", this.commentCurrentPage);
      let pageList = [];
      for (
        let i = 10 * (val - 1);
        i < (10 * val < this.commentTotal ? 10 * val : this.commentTotal);
        i++
      ) {
        console.log("i", i);
        pageList.push(this.commentList[i]);
      }
      console.log("this.commentList", pageList);
      this.pageListC = pageList;
      console.log("this.pageListC", this.pageListC);
    },

    handleClick() {
      this.cancelAdd();
      this.isAdding = false;

      if (this.activeName == "second") {
        console.log("second");
        this.fetchVideo();
      }

      if (this.activeName == "third") {
        console.log("third");
        this.fetchComment();
      }
    }
  },
  filters: {
    videoLinkSplice(value) {
      if (!value) return "";
      value = value.toString();
      return value.substring(0, 100) + "...";
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

  .close-button {
    position: absolute;
    right: 120px;
    bottom: 60px;
  }
}

.video-pagination {
  display: inline-block;
  margin-top: 30px;
  margin-left: 50%;
  transform: translateX(-50%);
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

.detail-button {
  color: #409eff;
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

.form-item {
  font-weight: bold;
  margin: 5px 0;
}

.form-item:nth-child(even) {
  background: #fafafa;
}

.form-item:hover {
  background: rgba(100, 150, 200, 0.1);
}
p {
  font-weight: normal;
  margin: 0;
  padding: 0;
  margin-left: 30px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 90%;
}

.lastP {
  word-wrap: break-word;
  white-space: pre-wrap;
  overflow: visible;
}
.newVideo {
  font-size: 14px;
  color: #606266;

  height: 23px;
  line-height: 23px;
  span {
    display: inline-block;
    min-width: 23px;
    height: 23px;
    text-align: center;
  }
  .ordinal {
    margin-left: 8px;
  }

  .ordinal-tip-start {
    margin-left: 20px;
  }

  .ordinal-input {
    width: 62px;
  }

  .ordinal-tip-end {
    margin-left: -5px;
  }

  .link-input {
    width: 67.6%;
    margin-left: 16px;
  }
}
</style>
