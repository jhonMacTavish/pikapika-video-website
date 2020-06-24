<template>
  <div>
    <h1>{{id?'编辑影视 ♥ '+this.modelF.name:'添加影视'}}</h1>

    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="基本信息" name="first" class="panel">
        <el-form
          :model="modelF"
          :rules="rules"
          ref="filmtv"
          label-width="200px"
          style="margin-right: 200px"
        >
          <el-form-item label="搜索片源" v-if="!id">
            <el-select
              v-model="searchUrl"
              :filterable="id?false:true"
              :placeholder="id?modelF.name:'请输入要查询的影视名称'"
              remote
              reserve-keyword
              :remote-method="serchFilm"
              :default-first-option="true"
              :loading="loading"
              no-data-text="未获取到相关数据"
            >
              <el-option
                v-for="(item,index) in options"
                :key="index"
                :label="item.name"
                :value="item.url"
              >
                <span style="float:left">{{item.name}}</span>
                <span style="float:right">{{item.genre}}</span>
                <span style="float:right">{{item.time}}</span>
              </el-option>
            </el-select>
            <!-- <el-input v-model="modelF.name" style="width:222px" maxlength="100"></el-input> -->
          </el-form-item>
          <el-form-item label="名称" prop="name">
            <el-input v-model="modelF.name" style="width:222px" maxlength="100"></el-input>
          </el-form-item>
          <el-form-item label="类型" prop="type_id">
            <el-select v-model="modelF.type_id" placeholder="请选择" disabled>
              <el-option
                v-for="item in types"
                :key="item.type_id"
                :label="item.text"
                :value="item.type_id"
              ></el-option>
            </el-select>
          </el-form-item>

          <!-- <el-form-item label="总集数" prop="episode">
            <el-input v-model="modelF.episode" style="width:222px" maxlength="4"></el-input>
          </el-form-item>-->
          <el-form-item label="状态" prop="is_ended">
            <el-select v-model="modelF.is_ended" placeholder="请选择">
              <el-option
                v-for="(item) in status"
                :key="item.id"
                :label="item.text"
                :value="item.id"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="风格" prop="style">
            <!-- <el-select
          v-model="modelF.style"
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
              v-for="tag in modelF.style"
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
          <el-form-item label="首字母" prop="initials">
            <el-select
              v-model="modelF.initials"
              placeholder="请选择"
              filterable
              :default-first-option="true"
            >
              <el-option
                v-for="item in initials"
                :key="item.id"
                :label="item.text"
                :value="item.text"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="开播时间" prop="playtime">
            <el-date-picker
              v-model="modelF.playtime"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="主演" prop="actors">
            <!-- <el-select
          v-model="modelF.actors"
          multiple
          filterable
          allow-create
          placeholder="请输入"
          :default-first-option="true"
          clearable
        >
          <el-option label="请编辑主演" value disabled></el-option>
            </el-select>-->
            <el-tag
              :key="tag"
              v-for="tag in modelF.actors"
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
              <i class="el-icon-plus"></i> 主演
            </el-button>
          </el-form-item>
          <el-form-item label="图片地址" prop="imgSrc">
            <el-input v-model="modelF.imgSrc" maxlength="500"></el-input>
          </el-form-item>
          <el-form-item label="简介" prop="summary">
            <el-input type="textarea" rows="3" v-model="modelF.summary" clearable maxlength="500" show-word-limit></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click.native="submitForm('filmtv')">保 存</el-button>
            <el-button @click="$router.push('/filmtv/list')">取 消</el-button>
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
          <el-table-column prop="episode" label="话数" width="130">
            <template slot-scope="scope">
              <div class="video-item">
                <span>第</span>
                <el-input
                  @keyup.enter.native="!isAdding?update(scope.row):confirmAdd(scope)"
                  class="episode"
                  v-model="scope.row.episode"
                  maxlength="4"
                ></el-input>
                <span>话</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="video_name" label="标题" width="250">
            <template slot-scope="scope">
              <el-input
                @keyup.enter.native="!isAdding?update(scope.row):confirmAdd(scope)"
                v-model="scope.row.video_name"
                @keyup.up.native="arrowUp($event)"
                @keyup.down.native="arrowDown($event)"
              ></el-input>
            </template>
          </el-table-column>
          <el-table-column prop="src" label="视频地址">
            <template slot-scope="scope">
              <el-input
                @keyup.enter.native="!isAdding?update(scope.row):confirmAdd(scope)"
                v-model="scope.row.src"
              ></el-input>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="200">
            <template slot-scope="scope">
              <div v-if="isAdding&&!scope.row.resource_id">
                <el-button
                  type="text"
                  class="confirm-button"
                  icon="el-icon-check"
                  @click="confirmAdd(scope)"
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
                  v-if="scope.row.resource_id"
                  type="text"
                  class="confirm-button"
                  icon="el-icon-edit-outline"
                  @click="update(scope.row)"
                  :disabled="isAdding"
                >修改</el-button>
                <el-button
                  v-if="scope.row.resource_id"
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
        <el-button type="danger" @click="$router.push('/filmtv/list')">关 闭</el-button>
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
          <el-table-column prop="c_uname" label="用户名" width="200">
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
          <el-table-column prop="content" label="评论内容" width="500"></el-table-column>
          <el-table-column prop="create_time" label="评论时间" width="230"></el-table-column>
          <el-table-column label="操作" width="200">
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
        <el-button type="danger" @click="$router.push('/filmtv/list')">关 闭</el-button>
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
          <p>
            <img :src="modelC.c_uavatar?modelC.c_uavatar:userAvatar" alt />
          </p>
        </el-form-item>
        <el-form-item label="评论内容" class="form-item">
          <p>{{modelC.content}}</p>
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
          <p>{{modelU.username}}</p>
        </el-form-item>
        <el-form-item label="用户头像" class="form-item">
          <!-- <p>{{modelU.avatar}}</p> -->
          <p>
            <img :src="modelU.avatar?modelU.avatar:userAvatar" alt />
          </p>
        </el-form-item>
        <el-form-item label="性别" class="form-item">
          <p>{{modelU.is_man==1?"女":"男"}}</p>
        </el-form-item>
        <el-form-item label="邮箱" class="form-item">
          <p>{{modelU.email}}</p>
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
    film_id: null
  },
  data() {
    let name = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入番名")); // 请输入番名
      } else {
        callback();
      }
    };

    let type_id = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择类型")); // 请输入番名
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let episode = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入集数")); // 请输入请输入集数
      } else {
        if (isNaN(Number(value))) {
          callback(new Error("请输入数字"));
        }
        callback();
      }
    };

    let style = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧风格")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let initials = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请选择首字母")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let playtime = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请选择开播时间")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    let actors = (rule, value, callback) => {
      if (value.length == 0) {
        callback(new Error("请编辑番剧主演")); // 请输入请输入集数
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

    let summary = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请填写番剧简介")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      id: null,
      userAvatar: "../../../static/userAvatar.jpg",
      rules: {
        name: [{ validator: name, trigger: "blur" }],
        type_id: [{ validator: type_id, trigger: "change" }],
        episode: [{ validator: episode, trigger: "blur" }],
        style: [{ validator: style, trigger: "blur" }],
        initials: [{ validator: initials, trigger: "change" }],
        playtime: [{ validator: playtime, trigger: "blur" }],
        actors: [{ validator: actors, trigger: "blur" }],
        imgSrc: [{ validator: imgSrc, trigger: "blur" }],
        summary: [{ validator: summary, trigger: "blur" }]
      },

      loading: false,
      searchID: null,
      queryCode: null,
      searchUrl: "",
      options: [],
      modelF: {
        searchUrl: "",
        name: "",
        type_id: 4,
        imgSrc: "",
        episode: "",
        is_ended: 0,
        style: [],
        initials: "",
        playtime: "",
        // quarter: "",
        years: "",
        actors: [],
        summary: ""
      },

      styleVisible: false,
      styleValue: "",

      actorsVisible: false,
      actorsValue: "",

      pageListV: [],
      videoCurrentPage: 1,

      activeName: "first",
      newVideo: {
        episode: 0,
        video_name: "",
        src: ""
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
    types() {
      return this.$store.getters.types;
    },

    status() {
      return this.$store.getters.status;
    },

    initials() {
      return this.$store.getters.initials;
    },

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
  watch: {
    searchUrl(newV, oldV) {
      if (newV != oldV) {
        this.modelF.searchUrl = newV;
        this.getEpisodes(newV);
      }
    }
  },
  created() {
    this.id = this.film_id;
    this.id && this.fetch();
  },
  methods: {
    arrowUp(e) {
      let currentNode = e.target.parentNode.parentNode.parentNode.parentNode;
      let currentNextBro = currentNode.previousElementSibling;
      if (!currentNextBro) {
        let length = currentNode.parentNode.childNodes.length - 1;
        currentNextBro = currentNode.parentNode.childNodes[length - 1];
      }
      let target =
        currentNextBro.childNodes[2].childNodes[0].childNodes[0].childNodes[1];
      target.focus();
    },
    arrowDown(e) {
      let currentNode = e.target.parentNode.parentNode.parentNode.parentNode;
      let currentNextBro = currentNode.nextElementSibling;
      if (!currentNextBro) {
        currentNextBro = currentNode.parentNode.childNodes[0];
      }
      let target =
        currentNextBro.childNodes[2].childNodes[0].childNodes[0].childNodes[1];
      target.focus();
    },
    serchFilm(query) {
      this.modelF.name = query;
      if (query !== "") {
        this.loading = true;
        clearTimeout(this.searchID);
        this.searchID = setTimeout(async () => {
          let queryCode = Math.floor(Math.random() * 9000) + 1000;
          this.queryCode = queryCode;
          if (query.indexOf("/" >= 0)) {
            query = query.replace("/","%2F")
          }
          const nameRst = await this.$http.get(`/getResources/${query}`, {
            params: { queryCode }
          });
          if (
            nameRst.data.status == 200 &&
            this.queryCode == nameRst.data.queryCode
          ) {
            this.options = nameRst.data.list;
          }
          this.loading = false;
        }, 500);
      }
    },

    async getEpisodes(url) {
      let queryCode = Math.floor(Math.random() * 9000) + 1000;
      this.queryCode = queryCode;
          if (query.indexOf("/" >= 0)) {
            query = query.replace("/","%2F")
          }
      const episodeRst = await this.$http.get(`/getEpisodes/${url}`, {
        params: { queryCode }
      });
      let list = episodeRst.data.list;
      let arr = [];
      for (let i = 0; i < list.length; i++) {
        arr.push(list[i].onlineurl);
      }
      // //console.log(arr);
      // if (
      //   nameRst.data.status == 200 &&
      //   this.queryCode == nameRst.data.queryCode
      // ) {
      //   this.options = nameRst.data.list;
      // }
    },

    validate(row) {
      if (!Number(row.episode)) {
        return false;
      }
      if (!row.video_name) {
        return false;
      }
      if (!row.src) {
        return false;
      }
      return true;
    },
    async userDetail(row) {
      const res = await this.$http.post(`/userinfos/${row.user_id}`);
      this.modelU = res.data[0];
      this.dialogFormVisibleU = true;
      //console.log("this.modelFU", this.modelU);
    },

    async commentRemove(row) {
      let res = await this.$http.delete(`/comments/${row.comment_id}`);

      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        await this.this.fetchComment();
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
      //console.log("modelC", this.modelC);
      this.dialogFormVisibleC = true;
    },

    async update(row) {
      if (this.isAdding) {
        this.$message({
          type: "error",
          message: "请先完成或取消添加视频"
        });
        return;
      }
      
      if (!this.validate(row)) {
        this.$message({
          type: "error",
          message: "请按正确格式将视频信息填写完整"
        });
        return;
      }
      let params = {
        resource_id: row.resource_id,
        episode: row.episode,
        video_name: row.video_name,
        src: row.src
      };
      let res = await this.$http.put(`/videos/${this.id}`, params);
      //console.log("delete", res);
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
      this.$confirm(`是否确定要删除番剧 "${row.name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          //console.log("delete", `/videos/${row.resource_id}`);
          const res = await this.$http.delete(`/videos/${row.resource_id}`);
          //console.log("delete", res);
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
      this.isAdding = true;
      let index = this.videoTotal;
      if (index != 0 && index == this.resources.length) {
        this.$message({
          type: "success",
          message: "已添加该剧的所有视频"
        });
        this.isAdding = false;
        return;
      }
      let resources = this.resources;
      if (resources.length) {
        this.newVideo = resources[index];
      }
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

    async confirmAdd(scope) {
      let row = scope.row;
      if (!this.isAdding || scope.$index + 1 != this.pageListV.length) {
        this.update(row);
        return;
      }
      if (!this.validate(row)) {
        this.$message({
          type: "error",
          message: "请按正确格式将视频信息填写完整"
        });
        return;
      }
      //console.log("confirmAdd", row);
      this.$store.commit("DeleteVideo");
      let params = this.newVideo;
      //console.log("params", params);
      params.episode = Number(params.episode);
      params.film_id = this.modelF.film_id;
      params.type_id = this.modelF.type_id;

      let res = await this.$http.post("/videos", params);
      //console.log("rst", res);

      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        await this.fetchVideo();
        this.isAdding = false;
        this.videoCurrentChange(this.videoCurrentPage);
        let arr = row.src.split(".");
        let length = 1;
        if (row.episode >= 9) {
          length = 2;
        }
        let src = `${arr[0].slice(0, -length)}${row.episode + 1}.${arr[1]}`;

        this.newVideo = {
          episode: 0,
          video_name: "",
          src: ""
        };
        this.addVideo();
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
          //console.log("save");

          var objString = JSON.stringify(this.modelF);
          var params = JSON.parse(objString);
          let timeSlice = params.playtime.split("-");
          params.years = timeSlice[0];
          // params.quarter = timeSlice[1];

          params.style = params.style.join("、");
          params.actors = params.actors.join("、");
          //console.log("params*************", params);

          let res;

          if (this.id) {
            //console.log("更新");
            res = await this.$http.put(`/filmtvs/${this.id}`, params);
          } else {
            //console.log("创建");
            res = await this.$http.post("/filmtvs", params);
          }

          //console.log("res***********", res);

          if (res.data.status == 200) {
            // this.$message({
            //   type: "success",
            //   message: res.data.msg
            // });
            // this.$router.push("/filmtv/list");

            if (!this.id) {
              this.$confirm(
                `${res.data.msg},是否添加"${params.name}"的视频资源?`,
                "提示",
                {
                  confirmButtonText: "确定",
                  cancelButtonText: "取消",
                  type: "success"
                }
              )
                .then(async () => {
                  this.id = res.data.film_id;
                  await this.fetch();
                  await this.fetchVideo();
                  await this.fetchComment();
                  this.activeName = "second";
                })
                .catch(() => {
                  this.$router.push("/filmtv/list");
                });
            } else {
              this.$message({
                type: "success",
                message: res.data.msg
              });
              this.$router.push("/filmtv/list");
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
      //console.log("save");
      var objString = JSON.stringify(this.modelF);
      var params = JSON.parse(objString);
      let timeSlice = params.playtime.split("-");
      params.years = timeSlice[0];
      // params.quarter = timeSlice[1];

      params.style = params.style.join("、");
      params.actors = params.actors.join("、");
      //console.log("params*************", params);
      const res = await this.$http.post("/filmtvs", params);
      //console.log("res***********", res);

      if (res.affectedRows === 1) {
        this.$message({
          type: "success",
          message: res.msg
        });
        this.$router.push("/filmtv/list");
      } else {
        this.$message({
          type: "error",
          message: res.msg
        });
      }
    },

    async fetch() {
      // //console.log("edit");
      const resF = await this.$http.get(`/filmtvs/${this.id}`);
      // //console.log("resF", resF.data[0].style.split("、"));

      resF.data[0].style = resF.data[0].style.split("、");
      resF.data[0].actors = resF.data[0].actors.split("、");

      this.modelF = resF.data[0];
      // //console.log("this.modelF", this.modelF);
      // let resV = await this.$http.get(`/videos/`, {
      //   params: { film_id: this.modelF.film_id, type_id: this.modelF.type_id }
      // });
      // // this.$store.dispatch("updateVideoList", resV.data.list);
      // this.$store.commit("UpdateVideoList", resV.data.list);

      // this.videoCurrentChange(this.videoCurrentPage);
      // //console.log("this.videoList", this.videoList);

      // let resC = await this.$http.get(`/comments/`, {
      //   params: { film_id: this.modelF.film_id, type_id: this.modelF.type_id }
      // });

      // //console.log("resC", resC.data.list);
      // this.$store.commit("UpdateCommentList", resC.data.list);
      // this.commentCurrentChange(this.commentCurrentPage);
    },
    async fetchVideo() {
      let resV = await this.$http.get(`/videos/`, {
        params: { film_id: this.modelF.film_id, type_id: this.modelF.type_id }
      });
      let list = resV.data.list;
      this.$store.commit("UpdateVideoList", list);
      this.videoCurrentChange(this.videoCurrentPage);
      // if (!list.length) {
      resV = await this.$http.get(`/getEpisodes/${this.modelF.searchUrl}`);
      //console.log("resV", resV);
      if (resV.data.status != 200) {
        this.$message({
          type: "error",
          message: "暂无该影视资源"
        });
        return;
      }
      let resources = resV.data.list;
      let arr = [];
      for (let i = 0; i < resources.length; i++) {
        let episode = resources[i].num;
        episode = Number(
          episode.indexOf(".") == -1 ? episode.slice(1, 3) : episode.slice(1, 4)
        );
        let video_name = "";
        let src = resources[i].onlineurl;
        arr[i] = { episode, video_name, src };
      }
      this.resources = arr;
    },

    // async fetchVideo() {
    //   let resV = await this.$http.get(`/videos/`, {
    //     params: { film_id: this.modelF.film_id, type_id: this.modelF.type_id }
    //   });
    //   //console.log("resV.data.list", resV.data.list);
    //   // this.$store.dispatch("updateVideoList", resV.data.list);
    //   this.$store.commit("UpdateVideoList", resV.data.list);

    //   this.videoCurrentChange(this.videoCurrentPage);
    //   if (this.activeName == "second" && this.videoTotal > 0) {
    //     let lastVideo = this.videoList[this.videoTotal - 1];
    //     let arr = lastVideo.src.split(".");
    //     let length = 1;
    //     if (lastVideo.episode >= 9) {
    //       length = 2;
    //     }
    //     let src = `${arr[0].slice(0, -length)}${lastVideo.episode + 1}.${
    //       arr[1]
    //     }`;

    //     this.newVideo = {
    //       episode: 0,
    //       video_name: "",
    //       src: ""
    //     };
    //   }
    // },

    async fetchComment() {
      let resC = await this.$http.get(`/comments/`, {
        params: { film_id: this.modelF.film_id, type_id: this.modelF.type_id }
      });

      //console.log("resC", resC.data.list);
      this.$store.commit("UpdateCommentList", resC.data.list);
      this.commentCurrentChange(this.commentCurrentPage);
    },

    styHandleClose(tag) {
      this.modelF.style.splice(this.modelF.style.indexOf(tag), 1);
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
        this.modelF.style.push(styleValue);
      } else {
        this.styleVisible = false;
      }
      this.styleValue = "";
    },

    actHandleClose(tag) {
      this.modelF.actors.splice(this.modelF.actors.indexOf(tag), 1);
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
        this.modelF.actors.push(actorsValue);
      } else {
        this.actorsVisible = false;
      }
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
      //console.log("this.commentTotal", this.commentTotal);
      if (Math.ceil(this.videoTotal / 10) < this.commentCurrentPage) {
        --this.commentCurrentPage;
      }

      if (val < 1) {
        val = 1;
      }
      //console.log("this.commentCurrentPage", this.commentCurrentPage);
      let pageList = [];
      for (
        let i = 10 * (val - 1);
        i < (10 * val < this.commentTotal ? 10 * val : this.commentTotal);
        i++
      ) {
        //console.log("i", i);
        pageList.push(this.commentList[i]);
      }
      //console.log("this.commentList", pageList);
      this.pageListC = pageList;
      //console.log("this.pageListC", this.pageListC);
    },

    handleClick() {
      this.cancelAdd();
      this.isAdding = false;

      if (this.activeName == "second") {
        //console.log("second");
        this.fetchVideo();
      }

      if (this.activeName == "third") {
        //console.log("third");
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

.video-pagination {
  display: inline-block;
  margin-top: 30px;
  margin-left: 50%;
  transform: translateX(-50%);
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

img {
  height: 40px;
  width: 40px;
  border-radius: 50%;
  border: 1px solid rgba(0, 0, 0, 0.1);
}

.el-select-dropdown__item span {
  min-width: 100px;
  text-align: center;
}
</style>
