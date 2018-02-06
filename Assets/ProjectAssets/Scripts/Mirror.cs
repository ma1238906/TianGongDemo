using UnityEngine;

public class Mirror : MonoBehaviour
{
    public bool NeedRevert = false;
    public Shader invertShader;
    private bool isInit;

    void Start()
    {
        invertShader = Shader.Find("Custom/InverseCamera");
        isInit = true;
    }

    static Material m_Material = null;
    protected Material material
    {
        get
        {
            if (m_Material == null)
            {
                m_Material = new Material(invertShader);
                m_Material.hideFlags = HideFlags.DontSave;
            }
            return m_Material;
        }
    }

    protected void OnDisable()
    {
        if (m_Material)
        {
            DestroyImmediate(m_Material);
        }
    }

    // Called by the camera to apply the image effect  
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (NeedRevert && isInit)
        {

            if (Screen.orientation == ScreenOrientation.Portrait || Screen.orientation == ScreenOrientation.PortraitUpsideDown)
            {
                material.SetFloat("_AxisX", 0);
            }
            else
            {
                material.SetFloat("_AxisX", 1);
            }

            Graphics.Blit(source, destination, material);
        }
        else Graphics.Blit(source, destination);
    }
}
