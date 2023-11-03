package org.homey.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.homey.domain.ASBoardVO;
import org.homey.domain.asCriteria;

public interface ASBoardMapper {
    public List<ASBoardVO> selectAllPaging(asCriteria cri);
    public List<ASBoardVO> selectAllPagingMe(@Param("mid") String mid, @Param("amount") int amount, @Param("pageNum") int pageNum);
    public int totalCount(asCriteria cri);
    public int update(ASBoardVO asBoardVO);
    public int delete(int bno);
    public int insert(ASBoardVO asBoardVO);
    public int insertSelectKey(ASBoardVO asBoardVO);

    public List<ASBoardVO> selectAll();
    public ASBoardVO select(int bno);
    

    // AS 게시물 답변 추가
    public void addReply(ASBoardVO asBoardVO);

    // AS 게시물 답변 수정
    public int updateReply(ASBoardVO asBoardVO);
    
    public List<ASBoardVO> selectReplyList(int bno);

    // AS 게시물 답변 삭제
    public int deleteReply(int bno);
}
