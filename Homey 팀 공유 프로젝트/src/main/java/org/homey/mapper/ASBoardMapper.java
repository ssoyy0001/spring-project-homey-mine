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
    public String selectemail(int bno);
    public List<ASBoardVO> selectAll();
    public ASBoardVO select(int bno);
    
}
