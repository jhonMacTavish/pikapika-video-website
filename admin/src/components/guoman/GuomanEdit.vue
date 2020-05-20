<template>
  <div>
    <h1>{{id?'编辑国漫 ♥ '+this.modelG.g_name:'添加国漫'}}</h1>
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="基本信息" name="first" class="panel">
        <el-form
          :model="modelG"
          :rules="rules"
          ref="guoman"
          label-width="200px"
          @submit.native.prevent="save"
          style="margin-right: 200px"
        >
          <el-form-item label="名称" prop="g_name">
            <el-input v-model="modelG.g_name" style="width:222px" maxlength="100"></el-input>
          </el-form-item>
          <el-form-item label="类型" prop="t_id">
            <el-select v-model="modelG.t_id" placeholder="请选择" disabled>
              <el-option
                v-for="item in types"
                :key="item.t_id"
                :label="item.text"
                :value="item.t_id"
              ></el-option>
            </el-select>
          </el-form-item>

          <!-- <el-form-item label="总集数" prop="g_episodes">
            <el-input v-model="modelG.g_episodes" style="width:222px" maxlength="4"></el-input>
          </el-form-item> -->
          <el-form-item label="状态" prop="g_status">
            <el-select v-model="modelG.g_status" placeholder="请选择">
              <el-option
                v-for="(item) in status"
                :key="item.id"
                :label="item.text"
                :value="item.id"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="风格" prop="g_style">
            <!-- <el-select
          v-model="modelG.g_style"
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
              v-for="tag in modelG.g_style"
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
          <el-form-item label="首字母" prop="g_initials">
            <el-select v-model="modelG.g_initials" placeholder="请选择">
              <el-option
                v-for="item in initials"
                :key="item.id"
                :label="item.text"
                :value="item.text"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="开播时间" prop="g_playtime">
            <el-date-picker
              v-model="modelG.g_playtime"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="声优" prop="g_actors">
            <!-- <el-select
          v-model="modelG.g_actors"
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
              v-for="tag in modelG.g_actors"
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
          <el-form-item label="图片地址" prop="g_imgSrc">
            <el-input v-model="modelG.g_imgSrc" maxlength="500"></el-input>
          </el-form-item>
          <el-form-item label="简介" prop="g_summary">
            <el-input type="textarea" rows="3" v-model="modelG.g_summary" clearable maxlength="500"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click.native="submitForm('guoman')">保 存</el-button>
            <el-button @click="$router.push('/guoman/list')">取 消</el-button>
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
        <el-button type="danger" @click="$router.push('/guoman/list')">关 闭</el-button>

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
          <el-table-column prop="c_uavatar" label="用户头像" width="100">
            <template slot-scope="scope">
              <img :src="scope.row.c_uavatar?scope.row.c_uavatar:userAvatar" alt />
            </template>
          </el-table-column>
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
        <el-button type="danger" @click="$router.push('/guoman/list')">关 闭</el-button>

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
          <!-- <p>{{modelC.c_uavatar}}</p> -->
          <p>
            <img :src="modelC.c_uavatar?modelC.c_uavatar:userAvatar" alt />
          </p>
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
          <!-- <p>{{modelU.u_avatar}}</p> -->
          <p>
            <img :src="modelU.u_avatar?modelU.u_avatar:userAvatar" alt />
          </p>
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
      userAvatar:'../../../static/userAvatar.jpg',
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

      modelG: {
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
        r_address: "http://localhost:3000/videos/guoman/"
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
      params.v_id = this.modelG.v_id;
      params.t_id = this.modelG.t_id;

      let res = await this.$http.post("/videos", params);
      console.log("rst", res);

      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        await this.fetchVideo();
        this.isAdding = false;
        this.videoCurrentChange(this.videoCurrentPage);
        
        let arr = row.r_address.split(".");
        let length = 1;
        if(row.r_episode>=9){
          length=2;
        }
        let r_address = `${arr[0].slice(0,-length)}${row.r_episode+1}.${arr[1]}`;

        this.newVideo = {
          r_episode: 0,
          r_address: r_address
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

          var objString = JSON.stringify(this.modelG);
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
            // this.$message({
            //   type: "success",
            //   message: res.data.msg
            // });
            // this.$router.push("/guoman/list");

            if (!this.id) {
              this.$confirm(
                `${res.data.msg},是否添加"${params.g_name}"的视频资源?`,
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
                  this.$router.push("/guoman/list");
                });
            } else {
              this.$message({
                type: "success",
                message: res.data.msg
              });
              this.$router.push("/guoman/list");
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

    async fetch() {
      // console.log("edit");
      const resG = await this.$http.get(`/guomans/${this.id}`);
      // console.log("resG", resG.data[0].g_style.split("、"));

      resG.data[0].g_style = resG.data[0].g_style.split("、");
      resG.data[0].g_actors = resG.data[0].g_actors.split("、");

      this.modelG = resG.data[0];
      // console.log("this.model", this.modelG);
      // let resV = await this.$http.get(`/videos/`, {
      //   params: { v_id: this.modelG.v_id, t_id: this.modelG.t_id }
      // });
      // this.$store.commit("UpdateVideoList", resV.data.list);

      // this.videoCurrentChange(this.videoCurrentPage);
      // console.log("this.videoList", this.videoList);

      // let resC = await this.$http.get(`/comments/`, {
      //   params: { v_id: this.modelG.v_id, t_id: this.modelG.t_id }
      // });

      // console.log("resC", resC.data.list);
      // this.$store.commit("UpdateCommentList", resC.data.list);
      // this.commentCurrentChange(this.commentCurrentPage);
    },

    async fetchVideo() {
      let resV = await this.$http.get(`/videos/`, {
        params: { v_id: this.modelG.v_id, t_id: this.modelG.t_id }
      });
      console.log("resV.data.list", resV.data.list);
      // this.$store.dispatch("updateVideoList", resV.data.list);
      this.$store.commit("UpdateVideoList", resV.data.list);

      this.videoCurrentChange(this.videoCurrentPage);
      if(this.activeName=="second" && this.videoTotal>0){
        let lastVideo = this.videoList[this.videoTotal-1];
        let arr = lastVideo.r_address.split(".");
        let length = 1;
        if(lastVideo.r_episode>=9){
          length = 2;
        }
        let r_address = `${arr[0].slice(0,-length)}${lastVideo.r_episode+1}.${arr[1]}`;

        this.newVideo = {
          r_episode: 0,
          r_address: r_address
        };

      }
    },

    async fetchComment(){
      let resC = await this.$http.get(`/comments/`, {
        params: { v_id: this.modelG.v_id, t_id: this.modelG.t_id }
      });

      console.log("resC", resC.data.list);
      this.$store.commit("UpdateCommentList", resC.data.list);
      this.commentCurrentChange(this.commentCurrentPage);
    },

    styHandleClose(tag) {
      this.modelG.g_style.splice(this.modelG.g_style.indexOf(tag), 1);
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
        this.modelG.g_style.push(styleValue);
      }

      this.styleVisible = false;
      this.styleValue = "";
    },

    actHandleClose(tag) {
      this.modelG.g_actors.splice(this.modelG.g_actors.indexOf(tag), 1);
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
        this.modelG.g_actors.push(actorsValue);
      }
      this.actorsVisible = false;
      this.actorsValue = "";
    },

    videoCurrentChange(val) {
      if (Math.ceil(this.videoTotal / 10) < this.videoCurrentPage) {
        --this.videoCurrentPage;
      }

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

    handleClick(){
      this.cancelAdd();
      this.isAdding=false;

      if(this.activeName == "second"){
        console.log("second", );
        this.fetchVideo();
      }

      if(this.activeName == "third"){
        console.log("third", );
        this.fetchComment();
      }
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
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

.confirm-button {
  // margin-left: 18px;
  color: #67c23a;
}

.delete-button {
  color: #f56c6c;
  margin-right: 20px;
  padding: 0;
  width: 40px;
  height: 40px;
}

.detail-button {
  color: #409eff;
}

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
img {
  height: 40px;
  width: 40px;
  border-radius: 50%;
  border: 1px solid rgba(0, 0, 0, 0.1);
}
</style>
