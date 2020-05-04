import Vue from 'vue';
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        types: [
            {
                t_id: 1,
                text: "番剧"
            },
            {
                t_id: 2,
                text: "国漫"
            },
            {
                t_id: 3,
                text: "电影"
            },
            {
                t_id: 4,
                text: "影视"
            }
        ],
        status: [
            {
                id: 1,
                text: "更新中"
            },
            {
                id: 2,
                text: "已完结"
            }
        ],
        initials: [
            {
                id: 1,
                text: "A"
            },
            {
                id: 2,
                text: "B"
            },
            {
                id: 3,
                text: "C"
            },
            {
                id: 4,
                text: "D"
            },
            {
                id: 5,
                text: "E"
            },
            {
                id: 6,
                text: "F"
            },
            {
                id: 7,
                text: "G"
            },
            {
                id: 8,
                text: "H"
            },
            {
                id: 9,
                text: "I"
            },
            {
                id: 10,
                text: "J"
            },
            {
                id: 11,
                text: "K"
            },
            {
                id: 12,
                text: "L"
            },
            {
                id: 13,
                text: "M"
            },
            {
                id: 14,
                text: "N"
            },
            {
                id: 15,
                text: "O"
            },
            {
                id: 16,
                text: "P"
            },
            {
                id: 17,
                text: "Q"
            },
            {
                id: 18,
                text: "R"
            },
            {
                id: 19,
                text: "S"
            },
            {
                id: 20,
                text: "T"
            },
            {
                id: 21,
                text: "U"
            },
            {
                id: 22,
                text: "V"
            },
            {
                id: 23,
                text: "W"
            },
            {
                id: 24,
                text: "X"
            },
            {
                id: 25,
                text: "Y"
            },
            {
                id: 26,
                text: "Z"
            }
        ],
        tags: [
            {
                id: 1,
                text: '剧场版'
            },
            {
                id: 2,
                text: '电影'
            }
        ],
        VGAs: [
            {
                id: 1,
                text: 'BD720P'
            },
            {
                id: 2,
                text: 'BD1080P'
            }
        ],

        bangumiList: [],
        guomanList: [],
        theaterList: [],
        filmtvList:[],
        userinfoList:[],
        videoList:[],   
        commentList:[]
    },
    getters: {
        tags: state => state.tags,
        VGAs:state => state.VGAs,
        types: state => state.types,
        status: state => state.status,
        initials: state => state.initials,

        bangumiList: state => state.bangumiList,
        guomanList: state => state.guomanList,
        theaterList: state => state.theaterList,
        filmtvList: state => state.filmtvList,
        userinfoList: state => state.userinfoList,
        videoList: state => state.videoList,
        commentList: state => state.commentList,
    },
    mutations: {
        UpdateBangumiList(state, bangumiList) {
            state.bangumiList = bangumiList;
        },
        UpdateGuomanList(state, guomanList) {
            state.guomanList = guomanList;
        },
        UpdateTheaterList(state, theaterList) {
            state.theaterList = theaterList;
        },
        UpdateFilmtvList(state,filmtvList){
            state.filmtvList = filmtvList;
        },
        UpdateUserinfoList(state,userinfoList){
            state.userinfoList = userinfoList;
        },
        UpdateVideoList(state,videoList){
            state.videoList = videoList;
        },
        UpdateCommentList(state,commentList){
            state.commentList = commentList;
        },
        AddVideo(state,video){
            state.videoList.push(video);
        },
        DeleteVideo(state){
            return state.videoList.pop();
        },
    },
    actions: {
        updateBangumiList({ commit }, bangumiList) {
            commit('UpdateBangumiList', bangumiList);
        },
        updateGuomanList({ commit }, guomanList) {
            commit('UpdateGuomanList', guomanList);
        },
        updateTheaterList({ commit }, theaterList) {
            commit('UpdateTheaterList', theaterList);
        },
        updateFilmtvList({commit},filmtvList){
            commit('UpdateFilmtvList',filmtvList);
        },
        updateUserinfoList({commit},userinfoList){
            commit('UpdateUserinfoList',userinfoList);
        },
        updateVideoList({commit},videoList){
            commit('UpdateVideoList',videoList);
        }
    }
})