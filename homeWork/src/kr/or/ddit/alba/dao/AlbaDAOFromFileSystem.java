package kr.or.ddit.alba.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.LinkedHashMap;
import java.util.Map;

import kr.or.ddit.vo.AlbaVO;

public class AlbaDAOFromFileSystem {
	private static AlbaDAOFromFileSystem albaDAO;
	private static final String filePath = "d:/sample/datafile.dat";
	private Map<String, AlbaVO> albaMap;
	private File dataFile;
	private AlbaDAOFromFileSystem(){
		try {
			dataFile = new File(filePath);
			if(!dataFile.exists()) {
				dataFile.createNewFile();//파일이 생성되면
				albaMap = new LinkedHashMap<String, AlbaVO>();//처음 생성시 얘를 먼저 읽어줄수 있도록 ㄴ
				writeToDataFile();
			}else {//파일이 존재하면
				try(//역직렬화 하기 위해서 인풋스트림
					FileInputStream fis = new FileInputStream(dataFile);
					ObjectInputStream ois = new ObjectInputStream(fis);
				){
					albaMap = (Map<String, AlbaVO>) ois.readObject();
					if(albaMap==null) albaMap = new LinkedHashMap<String, AlbaVO>();
				}		
			}
		}catch(Exception e) {
			throw new RuntimeException(e);
		}		
	}
	public static AlbaDAOFromFileSystem getInstance() {
		if(albaDAO==null)
			albaDAO = new AlbaDAOFromFileSystem();
		return albaDAO;
	}
	//파일시스템의 맵을 다시 기록해줘야되	
	public AlbaVO insertAlba(AlbaVO albaVO) throws IOException {
		String id = String.format("alba_%03d",albaMap.size()+1);
		albaVO.setId(id);
		AlbaVO preValue = albaMap.put(albaVO.getId(), albaVO);
		writeToDataFile();
		return preValue;
	}
	
	public AlbaVO selectAlba(String albaId){
		return albaMap.get(albaId);
	}
	
	public Map<String, AlbaVO> selectAlbaList(){
		return albaMap;
	}
	
	public AlbaVO updateAlba(AlbaVO albaVO) throws IOException {
		AlbaVO preValue = albaMap.put(albaVO.getId(), albaVO);
		writeToDataFile();
		return preValue;
	}
	
	public AlbaVO deleteAlba(String albaId) throws IOException {
		AlbaVO preValue = albaMap.remove(albaId);
		writeToDataFile();
		return preValue;
	}
	//기존의 파일시스템 맵을 다시 바꿔치기하는것 
	public void writeToDataFile() throws IOException{
		try(
			FileOutputStream fos = new FileOutputStream(dataFile);
			ObjectOutputStream oos = new ObjectOutputStream(fos);	
		){
			oos.writeObject(albaMap);
		}				
	}
}













